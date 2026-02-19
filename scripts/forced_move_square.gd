@tool
extends Square
class_name ForcedMoveSquare


@export_enum("Bomb", "Ladder") var icon: String:
	set(value):
		icon = value
		if value == "Bomb":
			$Icon.texture = load("res://icons/Bomb.png")
			color = Color.MIDNIGHT_BLUE
		if value == "Ladder":
			$Icon.texture = load("res://icons/Ladder.png")
			color = Color.SANDY_BROWN
	get:
		return icon


#De combien le joueur va avancer en atterissant sur cette case
@export var forced_move: int = -2
