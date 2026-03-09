extends Control
## Ecran de fin permettant d'afficher le gagnant et relancer une partie
class_name EndScreen

var _start_menu := load("res://scenes/main_menu.tscn")

## Indique l'équipe gagnante à l'écran
func initialize(winner: Team) -> void:
	$Label.text = str("L'équipe ", winner.team_name, " a gagnée !")
	
## Remet à l'écran d'accueil
func _on_button_pressed() -> void:
	var start_instance = _start_menu.instantiate()
	get_tree().root.add_child(start_instance)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = start_instance
