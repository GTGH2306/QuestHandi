extends Control
class_name HomeMenu

func _on_button_quit_pressed() -> void:
	get_tree().quit()

var menu_scene := preload("res://scenes/main_menu.tscn")
func _on_play_button_pressed() -> void:
	var menu_instance := menu_scene.instantiate()
	get_tree().root.add_child(menu_instance)
	get_tree().current_scene. queue_free()
	get_tree().current_scene = menu_instance
