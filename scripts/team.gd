extends Node3D
class_name Team

var pawn_res := preload("res://addons/pawn/scenes/pawn.tscn")

var team_name: String
var team_pawn: Pawn
var square_pos: int = 0
var last_response: bool = true

func _init(tcolor: Color, tname: String):
	team_name = tname
	team_pawn = pawn_res.instantiate()
	add_child(team_pawn)
	team_pawn.color = tcolor
