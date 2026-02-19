extends Node3D
class_name Game

var dice_res := preload("res://addons/dice/scenes/dice.tscn")
var question_interface := preload("res://scenes/question_card.tscn")
var end_screen := preload("res://scenes/end_screen.tscn")
@onready var pos_d1: Vector3 = $DiceSpawn.position
var trw: Vector3 = Vector3(-8, 0, 0)
@onready var pos_d2: Vector3 = $DiceSpawn.position + Vector3(1.5,0,0)

var question_manager: QuestionManager

var nbTeams: int
var current_turn = 0
var Teams: Array[Team] = [
	Team.new(Color.CRIMSON, "Rouge" ),
	Team.new(Color.CORNFLOWER_BLUE, "Bleue" ),
	Team.new(Color.FOREST_GREEN, "Verte" ),
	Team.new(Color.ORANGE, "Orange"),
	Team.new(Color.HOT_PINK, "Rose")
]

func initialize(nbPawns: int) -> void:
	nbTeams = nbPawns
	var start_square: Square = $Board.get_children()[0]
	#Pour chaque équipe, ajoute un pion de l'équipe.
	#A CHANGER les équipes doivent être des animaux choisi à l'acceuil
	#A CHANGER l'ordre des équipe doit être aléatoire
	for i in nbTeams:
		$Teams.add_child(Teams[i])
		Teams[i].team_pawn.position = start_square.positions[i].global_position
	#Assure la présence des fichiers et créer l'objet permettant de gérer les questions
	FileManager.ensure_folders()
	question_manager = QuestionManager.new()

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

func move_current_pawn(squares: int) -> void:
	var target_square_pos: int = Teams[current_turn].square_pos + squares
	if target_square_pos >= $Board.get_children().size() - 1:
		target_square_pos = $Board.get_children().size() - 1
		#print("L'équipe ", Teams[current_turn].team_name, " a gagnée!")
		var end: EndScreen = end_screen.instantiate()
		end.initialize(Teams[current_turn])
		get_tree().root.add_child(end)
		get_tree().current_scene. queue_free()
		get_tree().current_scene = end
	var target_square: Square = $Board.get_children()[target_square_pos]
	Teams[current_turn].team_pawn.move_to(target_square.get_available_position())
	Teams[current_turn].square_pos += squares
	_on_team_moved(target_square)

func _on_team_moved(target : Square) -> void:
	if target is QuestionSquare:
		ask_question(Teams[current_turn], target.question_color)
	if target is ForcedMoveSquare:
		move_current_pawn(target.forced_move)

func ask_question(team: Team, question_clr: Globals.clr) -> void:
	var qst_menu: QuestionCard = question_interface.instantiate()
	var question: Question = question_manager.draw_question(question_clr)
	qst_menu.initialize(question, question_clr, team)
	$".".add_child(qst_menu)
	qst_menu.question_answered.connect(_on_question_answered)

func _on_question_answered(result : bool):
	Teams[current_turn].last_response = result
	end_turn()

func end_turn() -> void:
	if current_turn + 1 >= nbTeams:
		current_turn = 0
	else:
		current_turn += 1
	$BoutonLancerDes/Label.text = str("Tour de l'équipe: ", Teams[current_turn].team_name)
	$BoutonLancerDes/Button.disabled = false
