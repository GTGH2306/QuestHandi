@tool
extends Square
class_name QuestionSquare


@export_enum("Rouge", "Verte", "Bleue", "Orange", "Rose")
var question_name: String:
	set(value):
		qst_name = value
		qst_clr = questions[qst_name]
		color = questions[qst_name]
	get:
		return qst_name
var qst_clr: Color
var qst_name: String
var color: Color:
	get:
		return $MeshInstance3D.get_active_material(0).albedo_color
	set(value):
		if has_node("MeshInstance3D"):
			$MeshInstance3D.material_override = $MeshInstance3D.get_active_material(0).duplicate()
			$MeshInstance3D.get_active_material(0).albedo_color = value
		if (has_node('SquareModel')):
			$SquareModel.set_surface_override_material(1, $MeshInstance3D.get_active_material(0))

func _ready() -> void:
	$SquareModel.set_surface_override_material(1, $MeshInstance3D.get_active_material(0))

const questions = {
	"Rouge": Color.RED,
	"Verte": Color.LIME_GREEN,
	"Bleue": Color.DEEP_SKY_BLUE,
	"Orange": Color.GOLDENROD,
	"Rose": Color.HOT_PINK
}
