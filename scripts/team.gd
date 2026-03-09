extends Node3D
## Gère une équipe et son pion
class_name Team

signal team_moved()

var pawn_res := preload("res://addons/pawn/scenes/pawn.tscn")

var last_response: bool = true
var team_name: String
var team_pawn: Pawn
var square_pos: int = 0
var move_left: int = 0

var start_transform
var target_transform
var move_speed : float = 1.8
var move_progress : float = 0.0
var move_distance : float = 0.0

## Indique le modèle de pion à utiliser et le nom de l'équipe
func _init(tpawnmdl: Pawn.Model, tname: String):
	team_name = tname
	team_pawn = pawn_res.instantiate()
	add_child(team_pawn)
	team_pawn.model = tpawnmdl

## Déplace le pion au fur et à mesure du temps si il y'a une case cible
func _process(delta: float) -> void:
	if target_transform && team_pawn.global_transform != target_transform:
		move_progress += move_speed * delta
		team_pawn.global_transform = start_transform.interpolate_with(target_transform, move_progress)
		if move_progress >= 1.0:
			team_pawn.global_transform = target_transform
			move_left -= 1
			target_transform = null
			if move_left > 0:
				team_pawn.animation_reset()
			emit_signal('team_moved')

## Redéfini la case cible
func move_to(new_pos: Vector3, new_rot: Vector3):
	start_transform = team_pawn.global_transform
	target_transform = Transform3D(Basis.from_euler(new_rot), new_pos)
	move_distance = team_pawn.global_position.distance_to(new_pos)
	move_progress = 0.0
