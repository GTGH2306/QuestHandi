extends Control

var game_scene := preload("res://scenes/game.tscn")
var Teams: Array[Team] = [
	Team.new(Pawn.Model.CAT, "Chat"),
	Team.new(Pawn.Model.DOG, "Chien"),
	Team.new(Pawn.Model.BUNNY, "Lapin"),
	Team.new(Pawn.Model.PENGUIN, "Pingouin"),
	Team.new(Pawn.Model.TORTOISE, "Tortue")
]


func _on_play_pressed() -> void:
	var game_instance = game_scene.instantiate()
	get_tree().root.add_child(game_instance)
	game_instance.initialize(get_playing_teams())
	get_tree().current_scene. queue_free()
	get_tree().current_scene = game_instance


func _on_check_box_pressed() -> void:
	if get_playing_teams().size() > 1:
		$Play_Button.disabled = false
	else:
		$Play_Button.disabled = true
	
func get_playing_teams() -> Array[Team]:
	var teams_playing : Array[Team] = []
	if $GridContainer/PanelContainer/VBoxContainer/CheckBox.button_pressed:
		teams_playing.append(Teams[0])
	if $GridContainer/PanelContainer2/VBoxContainer2/CheckBox.button_pressed:
		teams_playing.append(Teams[1])
	if $GridContainer/PanelContainer3/VBoxContainer3/CheckBox.button_pressed:
		teams_playing.append(Teams[2])
	if $GridContainer/PanelContainer4/VBoxContainer4/CheckBox.button_pressed:
		teams_playing.append(Teams[3])
	if $GridContainer/PanelContainer5/VBoxContainer5/CheckBox.button_pressed:
		teams_playing.append(Teams[4])
	return teams_playing
