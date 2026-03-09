@tool
extends SpecialSquare
## Gère le comportement liés aux cases question
class_name QuestionSquare
var _question_interface := preload("res://scenes/question_card.tscn")

## Couleur du thème de la question
@export var question_color: Globals.clr:
	set(value):
		question_color = value
		if Globals.is_node_ready():
			_update_color(Globals.qst_clr[value].clr)
	get:
		return question_color

## Change la couleur de la case
func _update_color(new_color: Color) -> void:
	if has_node("MeshInstance3D"):
		$MeshInstance3D.material_override = $MeshInstance3D.get_active_material(0).duplicate()
		$MeshInstance3D.get_active_material(0).albedo_color = new_color
	if has_node('SquareModel'):
		$SquareModel.set_surface_override_material(1, $MeshInstance3D.get_active_material(0))

## Au démarage, applique la couleur sélectionnée sur la case
func _ready() -> void:
	if has_node("MeshInstance3D") and has_node('SquareModel'):
		$SquareModel.set_surface_override_material(1, $MeshInstance3D.get_active_material(0))

## Surcharge de la méthode imposée par SpecialSquare
func apply_effect(_game: Game) -> void:
	_ask_question(_game)

## Ouvre une carte question pour l'équipe courante et attend le signal que l'équipe à répondu
func _ask_question(_game: Game) -> void:
	var qst_menu: QuestionCard = _question_interface.instantiate()
	var question: Question = _game.question_manager.draw_question(question_color)
	qst_menu.initialize(question, question_color, _game.current_team)
	$".".add_child(qst_menu)
	qst_menu.question_answered.connect(_on_question_answered)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	_game.asking_question = true

## Lorsque la suestion a été répondu, termine le tour de l'équipe courante
func _on_question_answered(result : bool):
	var game: Game = get_tree().current_scene
	if game:
		game.current_team.last_response = result
		game.asking_question = false
		game.end_turn()
