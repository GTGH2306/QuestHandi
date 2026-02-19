@tool
extends AnimatableBody3D
class_name Pawn

enum Model { BASE, CAT, DOG, BUNNY, PENGUIN, TORTOISE }
@onready var models = {
	Model.BASE: $pawn_basemodel,
	Model.CAT: $pawn_cat,
	Model.DOG: $pawn_dog,
	Model.BUNNY: $pawn_bunny,
	Model.PENGUIN: $pawn_penguin,
	Model.TORTOISE: $pawn_tortoise
}
var current_model:Model = Model.BASE
#permet de changer le modèle du pion
@export var model: Model:
	get:
		return current_model
	set(value):
		if models != null:
			models[current_model].visible = false
		current_model = value
		if models != null:
			models[current_model].visible = true

func _ready() -> void:
	for m in models.values():
		m.visible = false
	models[current_model].visible = true


@export var color: Color:
	get:
		return $pawn_basemodel.get_active_material(0).albedo_color
	set(value):
		$pawn_basemodel.material_override = $pawn_basemodel.get_active_material(0).duplicate()
		$pawn_basemodel.get_active_material(0).albedo_color = value
	
	
func move_to(newTarget: Vector3):
	position = newTarget
