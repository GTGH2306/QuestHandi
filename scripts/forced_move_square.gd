@tool
extends SpecialSquare
## Code d'une case qui gère un mouvement forcé. (Bombe/Echelle)
class_name ForcedMoveSquare

## Change la couleur de la case et place l'icone correspondante
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

## De combien le joueur va avancer/reculer en atterissant sur cette case
@export var forced_move: int = -2


## Surcharge la méthode de SpecialSquare pour appliquer l'effet de la case
func apply_effect(_game: Game) -> void:
	_forced_move(_game)

## Applique le mouvement à l'équipe courante depuis la case sur laquelle elle ce trouve et demande au pion de jouer une animation.
func _forced_move(_game: Game) -> void:
	var target_square_pos: int = _game.current_team.square_pos + forced_move
	var target_square: Square = _game.squares[target_square_pos]
	_game.current_team.move_to(target_square.get_available_position(), target_square.rotation)
	_game.current_team.square_pos += forced_move
	if forced_move > 0:
		_game.current_team.team_pawn.joy()
	else:
		_game.current_team.team_pawn.explode()
