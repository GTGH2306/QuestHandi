extends Control
class_name EndScreen

var start_menu := load("res://scenes/main_menu.tscn")

func initialize(winner: Team) -> void:
	$Label.text = str("L'équipe ", winner.team_name, " a gagnée !")


#Remet à l'écran principale
func _on_button_pressed() -> void:
	var start_instance = start_menu.instantiate()
	get_tree().root.add_child(start_instance)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = start_instance
