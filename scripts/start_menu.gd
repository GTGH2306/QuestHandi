extends Control
class_name StartMenu

var game_scene := preload("res://scenes/game.tscn")
var nb_pawns : int

func _on_pawn_nb_item_selected(index: int) -> void:
	$PlayButton.disabled = index < 0
	nb_pawns = $PawnNb.selected + 2


func _on_play_button_pressed() -> void:
	var game_instance = game_scene.instantiate()
	get_tree().root.add_child(game_instance)
	game_instance.initialize(nb_pawns)
	get_tree().current_scene. queue_free()
	get_tree().current_scene = game_instance
	
