extends Node3D
var follow_speed : float = 10.0
var target_pos: Vector3 = Vector3.ZERO
var offset : Vector3 = Vector3(0, 2, 0)

func _ready() -> void:
	set_as_top_level(true)
	var parent : Pawn = get_parent()
	if parent:
		global_position = parent.global_position + offset

func _process(delta: float) -> void:
	var parent : Pawn = get_parent()
	if parent:
		target_pos = parent.global_position + offset
	global_position = global_position.lerp(target_pos, follow_speed * delta)
