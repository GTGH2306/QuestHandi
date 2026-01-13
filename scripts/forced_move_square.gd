extends Square
class_name ForcedMoveSquare

@export var forced_move: int = -2

func _ready() -> void:
	$MeshInstance3D.material_override = StandardMaterial3D.new()
	$MeshInstance3D.material_override.albedo_color = Color.BLACK
