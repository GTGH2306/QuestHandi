@tool
extends Square
class_name QuestionSquare
@export var question_color: Globals.clr:
	set(value):
		qst_clr = value
		_update_color(Globals.qst_clr[value].clr)
	get:
		return qst_clr

func _update_color(new_color: Color) -> void:
	if has_node("MeshInstance3D"):
		$MeshInstance3D.material_override = $MeshInstance3D.get_active_material(0).duplicate()
		$MeshInstance3D.get_active_material(0).albedo_color = new_color
	if has_node('SquareModel'):
		$SquareModel.set_surface_override_material(1, $MeshInstance3D.get_active_material(0))

var qst_clr: Globals.clr

func _ready() -> void:
	if has_node("MeshInstance3D") and has_node('SquareModel'):
		$SquareModel.set_surface_override_material(1, $MeshInstance3D.get_active_material(0))
