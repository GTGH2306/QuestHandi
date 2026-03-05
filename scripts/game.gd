extends Node3D
class_name Game

var dice_res := preload("res://addons/dice/scenes/dice.tscn")
var question_interface := preload("res://scenes/question_card.tscn")
var end_screen := preload("res://scenes/end_screen.tscn")
@onready var pos_d1: Vector3 = $DiceSpawn.position
var trw: Vector3 = Vector3(-8, 0, 0)
@onready var pos_d2: Vector3 = $DiceSpawn.position + Vector3(1.5,0,0)

@export var sensitivity: float = 0.5

var asking_question: bool = false
var _pitch: float = 0.0
var _yaw: float = 0.0

var question_manager: QuestionManager

var current_turn = 0
var Teams: Array[Team]

func initialize(teams_playing: Array[Team]) -> void:
	Teams = teams_playing
	Teams.shuffle()
	var start_square: Square = $Board.get_children()[0]
	#Pour chaque équipe, ajoute le pion de l'équipe.
	for i in Teams.size():
		Teams[i].connect('team_moved', _on_team_moved)
		Teams[i].connect('team_landed', _on_team_landed)
		
		$Teams.add_child(Teams[i])
		var target_pos: Vector3 = start_square.positions[i].global_position
		var target_rot: Vector3 = start_square.global_rotation
		
		Teams[i].team_pawn.transform = Transform3D(Basis.from_euler(target_rot), target_pos)

	$BoutonLancerDes/Label.text = str("Tour de l'équipe: ", Teams[current_turn].team_name)
	#Assure la présence des fichiers et créer l'objet permettant de gérer les questions
	FileManager.ensure_folders()
	question_manager = QuestionManager.new()
	%CameraPivot.global_position = Teams[current_turn].team_pawn.pivot_point.global_position
	%CameraPivot.reparent(Teams[current_turn].team_pawn.pivot_point)

#Supprime les dés exustabts et lance des nouveaux dés. 1seul en cas de dernière réponse fausse.
func throw_dice() -> void:
	for die in $Dices.get_children():
		die.queue_free()
	
	var d1: Dice = dice_res.instantiate()
	d1.ThrowForce = trw
	d1.connect("dice_landed", _on_dice_landing)
	$Dices.add_child(d1)
	d1.global_position = pos_d1

	if (Teams[current_turn].last_response):
		var d2: Dice = dice_res.instantiate()
		d2.ThrowForce = trw
		d2.connect("dice_landed", _on_dice_landing)
		$Dices.add_child(d2)
		d2.global_position = pos_d2
#Permet de récuperer les dés sur le plateau, utile pour en prendre le résultat final
func get_array_dice(array: Array) -> Array[Dice]:
	var result: Array[Dice]
	for node in array:
		if node is Dice:
			result.append(node)
	return result

func _on_button_pressed() -> void:
	throw_dice()
	$BoutonLancerDes/Button.disabled = true

#Lorsqu'un dé s'arrête, si tout les dés sont arrêtés, appel la fonctions pour bouger le pion courant
func _on_dice_landing(_value: int) -> void:
	var dices : Array[Dice] = get_array_dice($Dices.get_children())
	var total:int = 0
	var all_landed := true
	for die in dices:
		total += die.get_value()
		if !die.landed:
			all_landed = false
	if all_landed:
		move_current_pawn(total)

func forced_move(squares: int) -> void:
	var target_square_pos: int = Teams[current_turn].square_pos + squares
	var target_square: Square = $Board.get_children()[target_square_pos]
	Teams[current_turn].move_to(target_square.get_available_position(), target_square.rotation)
	Teams[current_turn].square_pos += squares
	if squares > 0:
		Teams[current_turn].team_pawn.joy()
	else:
		Teams[current_turn].team_pawn.explode()

func move_current_pawn(squares: int) -> void:
	Teams[current_turn].move_left = squares
	var target_square_pos: int = Teams[current_turn].square_pos + 1
	if target_square_pos >= $Board.get_children().size():
		target_square_pos = $Board.get_children().size()
		Teams[current_turn].move_left = $Board.get_children().size() - Teams[current_turn].square_pos
	else:
		Teams[current_turn].square_pos += 1
	var target_square: Square = $Board.get_children()[target_square_pos]
	Teams[current_turn].move_to(target_square.get_available_position(), target_square.rotation)
	Teams[current_turn].team_pawn.hop()

func _on_team_moved():
	var target_square_pos: int = Teams[current_turn].square_pos + 1
	if target_square_pos >= $Board.get_children().size():
		target_square_pos = $Board.get_children().size() - 1
		Teams[current_turn].move_left = 0
	else:
		Teams[current_turn].square_pos += 1
	var target_square: Square = $Board.get_children()[target_square_pos]
	Teams[current_turn].move_to(target_square.get_available_position(), target_square.rotation)
	Teams[current_turn].team_pawn.hop()

func _on_team_landed() -> void:
	$LandingTimer.start()
	
func _on_landing_timer_timeout() -> void:
	$LandingTimer.stop()
	var team_square : Square = $Board.get_children()[Teams[current_turn].square_pos]
	if team_square == $Board.get_children()[$Board.get_children().size() - 1]:
		var end_instance: EndScreen = end_screen.instantiate()
		end_instance.initialize(Teams[current_turn])
		get_tree().root.add_child(end_instance)
		get_tree().current_scene.queue_free()
		get_tree().current_scene = end_instance
	if team_square is QuestionSquare:
		ask_question(Teams[current_turn], team_square.question_color)
	if team_square is ForcedMoveSquare:
		forced_move(team_square.forced_move)

func ask_question(team: Team, question_clr: Globals.clr) -> void:
	var qst_menu: QuestionCard = question_interface.instantiate()
	var question: Question = question_manager.draw_question(question_clr)
	qst_menu.initialize(question, question_clr, team)
	$".".add_child(qst_menu)
	qst_menu.question_answered.connect(_on_question_answered)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	asking_question = true

func _on_question_answered(result : bool):
	Teams[current_turn].last_response = result
	asking_question = false
	end_turn()

func end_turn() -> void:
	if current_turn + 1 >= Teams.size():
		current_turn = 0
	else:
		current_turn += 1
	$BoutonLancerDes/Label.text = str("Tour de l'équipe: ", Teams[current_turn].team_name)
	$BoutonLancerDes/Button.disabled = false
	%CameraPivot.global_position = Teams[current_turn].team_pawn.pivot_point.global_position
	%CameraPivot.reparent(Teams[current_turn].team_pawn.pivot_point)
	
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
			
func _process(_delta: float) -> void:
	
	%CameraPivot.global_position = Teams[current_turn].team_pawn.pivot_point.global_position

	%CameraPivot.global_rotation = Vector3.ZERO
	%CameraPivot.global_rotation.y = deg_to_rad(_yaw)

	%CameraPivot/x_pivot.rotation = Vector3.ZERO
	%CameraPivot/x_pivot.rotation.x = deg_to_rad(_pitch)
