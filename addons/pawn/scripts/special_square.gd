## Classe abstraite dont hérite les cases ayant un effet
extends Square
class_name SpecialSquare

## Méthode a surcharger. 
## "Abstract" et "Virtual" n'existent pas en GDScript
func apply_effect(_game: Game) -> void:
	push_warning("SpecialSquare.apply_effect() n'est pas implémenté dans %s" % get_class())
