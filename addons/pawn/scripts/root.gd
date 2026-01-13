extends Node3D


func _on_timer_timeout() -> void:
	
	$Pawn.move_to($Square.get_available_position())
	await get_tree().create_timer(1.0).timeout
	$Pawn2.move_to($Square.get_available_position())
	await get_tree().create_timer(1.0).timeout
	$Pawn2.move_to($Square2.get_available_position())
	await get_tree().create_timer(1.0).timeout
	$Pawn.move_to($Square2.get_available_position())
	await get_tree().create_timer(1.0).timeout
	$Pawn.move_to($Square3.get_available_position())
	await get_tree().create_timer(1.0).timeout
