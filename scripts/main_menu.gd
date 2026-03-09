extends Control

var game_scene := preload("res://scenes/game.tscn")
## Tableau des équipes possible à jouer
var TEAMS: Array[Team] = [
	Team.new(Pawn.Model.CAT, "Chat"),
	Team.new(Pawn.Model.DOG, "Chien"),
	Team.new(Pawn.Model.BUNNY, "Lapin"),
	Team.new(Pawn.Model.PENGUIN, "Pingouin"),
	Team.new(Pawn.Model.TORTOISE, "Tortue")
]

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
	if $GridContainer/PanelContainer/VBoxContainer/CheckBox.button_pressed:
		teams_playing.append(TEAMS[0])
	if $GridContainer/PanelContainer2/VBoxContainer2/CheckBox.button_pressed:
		teams_playing.append(TEAMS[1])
	if $GridContainer/PanelContainer3/VBoxContainer3/CheckBox.button_pressed:
		teams_playing.append(TEAMS[2])
	if $GridContainer/PanelContainer4/VBoxContainer4/CheckBox.button_pressed:
		teams_playing.append(TEAMS[3])
	if $GridContainer/PanelContainer5/VBoxContainer5/CheckBox.button_pressed:
		teams_playing.append(TEAMS[4])
	return teams_playing
