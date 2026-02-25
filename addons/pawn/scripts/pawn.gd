@tool
extends AnimatableBody3D
class_name Pawn
@onready var pivot_point: Node3D = $PivotPoint

enum Model { BASE, CAT, DOG, BUNNY, PENGUIN, TORTOISE }
@onready var models = {
	Model.BASE: $MeshBase/pawn_basemodel,
	Model.CAT: $MeshBase/pawn_cat,
	Model.DOG: $MeshBase/pawn_dog,
	Model.BUNNY: $MeshBase/pawn_bunny,
	Model.PENGUIN: $MeshBase/pawn_penguin,
	Model.TORTOISE: $MeshBase/pawn_tortoise
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
		return $MeshBase/pawn_basemodel.get_active_material(0).albedo_color
	set(value):
		$MeshBase/pawn_basemodel.material_override = $MeshBase/pawn_basemodel.get_active_material(0).duplicate()
		$MeshBase/pawn_basemodel.get_active_material(0).albedo_color = value
	
	
func move_to(newTarget: Vector3):
	position = newTarget
	
func hop():
	$AnimationPlayer.play("hop")
	
func animation_reset():
	$AnimationPlayer.play("RESET")

func joy():
	$AnimationPlayer.play("hop")
	
func explode():
	$AnimationPlayer.play("explode")
