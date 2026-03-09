@tool
extends StaticBody3D
class_name Square

@onready var positions: Array[RayCast3D] = [
	$RayCast_Pos1,
	$RayCast_Pos2,
	$RayCast_Pos3,
	$RayCast_Pos4, 
	$RayCast_Pos5,
]

## Fonction helper pour mettre à jour la couleur sans passer par le setter/getter
func _update_color(new_color: Color) -> void:
	if has_node("MeshInstance3D"):
		$MeshInstance3D.material_override = $MeshInstance3D.get_active_material(0).duplicate()
		$MeshInstance3D.get_active_material(0).albedo_color = new_color
	if has_node('Square'):
		$Square.set_surface_override_material(1, $MeshInstance3D.get_active_material(0))

## Permet de changer la couleur de la case.[/br]
## Différent de "QuestionSquare" qui a une liste de couleures pré-défini.
@export var color: Color:
	get:
		if has_node("MeshInstance3D"):
			return $MeshInstance3D.get_active_material(0).albedo_color
		return Color.WHITE
	set(value):
		_update_color(value)

## Retourne une position sur la case sur laquelle aucun pion n'est détecté
func get_available_position() -> Vector3:
	var result: Vector3 = Vector3.ZERO
	var i: int = 0
	while result == Vector3.ZERO:
		if !positions[i].is_colliding():
			result = positions[i].global_position
		i += 1
		if i > positions.size() - 1:
			push_error("Could not find available position.")
	return result
