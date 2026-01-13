extends StaticBody3D
class_name Square

@onready var positions: Array[RayCast3D] = [$RayCast_Pos1, $RayCast_Pos2, $RayCast_Pos3, $RayCast_Pos4, $RayCast_Pos5]


func get_available_position() -> Vector3:
	var result: Vector3 = Vector3.ZERO
	var i: int = 0
	while result == Vector3.ZERO && i < positions.size():
		if !positions[i].is_colliding():
			result = positions[i].global_position
		i += 1
	return result
