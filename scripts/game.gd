extends Node3D
## Gère les règles du jeu et la gestion des tours
class_name Game

var _dice_res := preload("res://addons/dice/scenes/dice.tscn")
var _end_screen := preload("res://scenes/end_screen.tscn")
@onready var _pos_d1: Vector3 = $DiceSpawn.position
var _trw: Vector3 = Vector3(-8, 0, 0)
@onready var _pos_d2: Vector3 = $DiceSpawn.position + Vector3(1.5,0,0)
var asking_question: bool = false
var _pitch: float = 0.0
var _yaw: float = 0.0
var question_manager: QuestionManager
var _current_turn:int = 0
var _teams: Array[Team]
var squares: Array[Square] = []
@export var sensitivity: float = 0.5

var current_team: Team:
	get:
		return _teams[_current_turn]

func _ready() -> void:
	#Assure la présence des fichiers et créer l'objet permettant de gérer les questions
	FileManager.ensure_folders()
	question_manager = QuestionManager.new()
	for child in $Board.get_children():
		if child is Square:
			squares.append(child)
		else:
			push_warning("L'enfant " + child.name + " n'est pas un Square !")
	assert(!squares.is_empty(), "ERREUR CRITIQUE: Board ne contient aucune cases")

## Ajoute les pions de chaque équipe dans un ordre de jeu aléatoire et place la camera sur la première équipe
func initialize(teams_playing: Array[Team]) -> void:
	if teams_playing.size() < 2 || teams_playing.size() > 5:
		push_error("Entre 2 et 5 équipes attendues: ", teams_playing.size(), " équipes reçues.")
		return
	_teams = teams_playing
	_teams.shuffle()
	var start_square: Square = squares[0]
	#Pour chaque équipe, ajoute le pion de l'équipe.
	for i in _teams.size():
		_teams[i].connect('team_moved', _on_team_moved)
		
		$Teams.add_child(_teams[i])
		var target_pos: Vector3 = start_square.positions[i].global_position
		var target_rot: Vector3 = start_square.global_rotation
		_teams[i].team_pawn.transform = Transform3D(Basis.from_euler(target_rot), target_pos)
		_teams[i].target_transform = Transform3D(Basis.from_euler(target_rot), target_pos)
	$BoutonLancerDes/Label.text = str("Tour de l'équipe: ", current_team.team_name)
	%CameraPivot.global_position = current_team.team_pawn.pivot_point.global_position
	%CameraPivot.reparent(current_team.team_pawn.pivot_point)

## Supprime les dés existants et lance des nouveaux dés.[br]
## 1 seul en cas de dernière réponse fausse.
func throw_dice() -> void:
	for die in $Dices.get_children():
		die.queue_free()
	
	var d1: Dice = _dice_res.instantiate()
	d1.throw_force = _trw
	d1.connect("dice_landed", _on_dice_landing)
	$Dices.add_child(d1)
	d1.global_position = _pos_d1

	if (current_team.last_response):
		var d2: Dice = _dice_res.instantiate()
		d2.throw_force = _trw
		d2.connect("dice_landed", _on_dice_landing)
		$Dices.add_child(d2)
		d2.global_position = _pos_d2
## Permet de récuperer les dés sur le plateau, utile pour en prendre le résultat final
func get_array_dice(array: Array) -> Array[Dice]:
	var result: Array[Dice]
	for node in array:
		if node is Dice:
			result.append(node)
	return result
## Lance les dés quand le bouton est appuyé
func _on_button_pressed() -> void:
	throw_dice()
	$BoutonLancerDes/Button.disabled = true

## Lorsqu'un dé s'arrête, si tout les dés sont arrêtés, appel la fonctions pour bouger le pion courant
func _on_dice_landing(_value: int) -> void:
	var dices: Array[Dice] = get_array_dice($Dices.get_children())
	var total: int = 0
	var all_landed := true
	for die in dices:
		total += die.get_value()
		if !die.landed:
			all_landed = false
	if all_landed:
		initialize_move(total)

## Indique à une équipe le nombre de case qu'elle doit parcourir
func initialize_move(squares_to_move: int) -> void:
	current_team.move_left = squares_to_move
	_move_current_pawn()

## Quand une équipe c'est déplacé, indique qu'elle a fini son mouvement si il ne lui en reste plus ou qu'elle est sur la dernière case.[/br]
## Sinon déclenche le prochain mouvement
func _on_team_moved():
	if current_team.move_left > 0 && current_team.square_pos < squares.size() - 1:
		_move_current_pawn()
	else:
		_on_team_landed()

## Déplace le pion de l'équipe courante sur la case suivante
func _move_current_pawn():
	var next_square_pos: int = current_team.square_pos + 1
	if next_square_pos >= squares.size():
		push_error("Case en dehors du plateau")
	current_team.square_pos += 1
	current_team.team_pawn.hop()
	var target_square: Square = squares[next_square_pos]
	current_team.move_to(target_square.get_available_position(), target_square.rotation)
	current_team.team_pawn.hop()
		
## Quand l'équipe atterit, attend 1s avant de déclencher la case
func _on_team_landed() -> void:
	$LandingTimer.start()
## Déclenche l'effet de la case après 1s
func _on_landing_timer_timeout() -> void:
	$LandingTimer.stop()
	var team_square : Square = squares[current_team.square_pos]
	if team_square == squares[squares.size() - 1]:
		_end_game()
	elif team_square is SpecialSquare:
		team_square.apply_effect(self)
## Gère la rotation de la caméra, si le curseur n'est pas sur un bouton
func _unhandled_input(event: InputEvent) -> void:
	if !asking_question:
		if event is InputEventMouseButton:
			if Input.is_action_pressed("Button_Click"):
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			else:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			if event.button_index == MOUSE_BUTTON_WHEEL_UP :
				if %CameraPivot/x_pivot/SpringArm3D.spring_length > 5:
					%CameraPivot/x_pivot/SpringArm3D.spring_length -= 0.3
			elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN :
				if %CameraPivot/x_pivot/SpringArm3D.spring_length < 20:
					%CameraPivot/x_pivot/SpringArm3D.spring_length += 0.3
		if event is InputEventMouseMotion && Input.is_action_pressed("Button_Click"):
			_yaw -= event.relative.x * sensitivity
			_pitch -= event.relative.y * sensitivity
			_pitch = clamp(_pitch, -65.0, 20.0)
			%CameraPivot/x_pivot.rotation.x = deg_to_rad(_pitch)
## Passe au tour suivant et met la caméra sur l'équipe suivante
func end_turn() -> void:
	if _current_turn + 1 >= _teams.size():
		_current_turn = 0
	else:
		_current_turn += 1
	$BoutonLancerDes/Label.text = str("Tour de l'équipe: ", current_team.team_name)
	$BoutonLancerDes/Button.disabled = false
	%CameraPivot.global_position = current_team.team_pawn.pivot_point.global_position
	%CameraPivot.reparent(current_team.team_pawn.pivot_point)
## Invoque l'écran de fin
func _end_game() -> void:
	var end_instance: EndScreen = _end_screen.instantiate()
	end_instance.initialize(current_team)
	get_tree().root.add_child(end_instance)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = end_instance

## Maintiens la camera sur la même rotation que l'horizon
func _process(_delta: float) -> void:
	
	%CameraPivot.global_position = current_team.team_pawn.pivot_point.global_position

	%CameraPivot.global_rotation = Vector3.ZERO
	%CameraPivot.global_rotation.y = deg_to_rad(_yaw)

	%CameraPivot/x_pivot.rotation = Vector3.ZERO
	%CameraPivot/x_pivot.rotation.x = deg_to_rad(_pitch)
