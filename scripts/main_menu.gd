extends Control
class_name SelectionMenu

var game_scene := preload("res://scenes/game.tscn")
## Tableau des équipes possible à jouer
var _teams: Array[Team] = [
	Team.new(Pawn.Model.CAT, "Chat"),
	Team.new(Pawn.Model.DOG, "Chien"),
	Team.new(Pawn.Model.BUNNY, "Lapin"),
	Team.new(Pawn.Model.PENGUIN, "Pingouin"),
	Team.new(Pawn.Model.TORTOISE, "Tortue")
]

@onready var cat_check: CheckBox = $GridContainer/PanelContainer/VBoxContainer/CheckBox
@onready var dog_check: CheckBox = $GridContainer/PanelContainer2/VBoxContainer2/CheckBox
@onready var bunny_check: CheckBox = $GridContainer/PanelContainer3/VBoxContainer3/CheckBox
@onready var pinguin_check: CheckBox = $GridContainer/PanelContainer4/VBoxContainer4/CheckBox
@onready var tortoise_check: CheckBox = $GridContainer/PanelContainer5/VBoxContainer5/CheckBox

## Lorsque le bouton est appuyé, lance la partie
func _on_play_pressed() -> void:
	var game_instance: Game = game_scene.instantiate()
	get_tree().root.add_child(game_instance)
	game_instance.initialize(get_playing_teams())
	get_tree().current_scene. queue_free()
	get_tree().current_scene = game_instance

## Active ou non le bouton "jouer" si le nombre d'équipe sélectionné est suffisant
func _on_check_box_pressed() -> void:
	if get_playing_teams().size() > 1:
		$Play_Button.disabled = false
	else:
		$Play_Button.disabled = true

## Retourne un tableau des équipes qui sont cochées comme jouant cette partie
func get_playing_teams() -> Array[Team]:
	var teams_playing : Array[Team] = []
	if cat_check.button_pressed:
		teams_playing.append(_teams[0])
	if dog_check.button_pressed:
		teams_playing.append(_teams[1])
	if bunny_check.button_pressed:
		teams_playing.append(_teams[2])
	if pinguin_check.button_pressed:
		teams_playing.append(_teams[3])
	if tortoise_check.button_pressed:
		teams_playing.append(_teams[4])
	return teams_playing


func _on_rotate_cat_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		cat_check.button_pressed = not cat_check.button_pressed
		_on_check_box_pressed()


func _on_rotate_dog_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		dog_check.button_pressed = not dog_check.button_pressed
		_on_check_box_pressed()


func _on_rotate_bunny_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		bunny_check.button_pressed = not bunny_check.button_pressed
		_on_check_box_pressed()


func _on_rotate_pinguin_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		pinguin_check.button_pressed = not pinguin_check.button_pressed
		_on_check_box_pressed()


func _on_rotate_tortoise_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		tortoise_check.button_pressed = not tortoise_check.button_pressed
		_on_check_box_pressed()
