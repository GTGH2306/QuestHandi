extends Node
## Variables globales afin d'assurer qu'on utilise les mêmes norme partout

## Le générateur de nombres aléatoire doit rester le même à travers le jeu
var rng : RandomNumberGenerator : 
	get:
		if random == null:
			random = RandomNumberGenerator.new()
		return random

var random : RandomNumberGenerator = null

## Enum des différentes couleurs de question possible
enum clr {
	RED,
	GREEN,
	BLUE,
	ORANGE,
	PINK
}

## Liaison entre le concept de couleur possible avec leur affichage en jeu et la couleur réel
var qst_clr:Dictionary[clr, QuestionColor] = {
	clr.BLUE: QuestionColor.new(Color.DEEP_SKY_BLUE, "Bleue"),
	clr.GREEN: QuestionColor.new(Color.LIME_GREEN, "Verte"),
	clr.ORANGE: QuestionColor.new(Color.GOLDENROD, "Orange"),
	clr.PINK: QuestionColor.new(Color.HOT_PINK, "Rose"),
	clr.RED: QuestionColor.new(Color.RED, "Rouge")
}

func get_qst_clr() -> Dictionary[clr, QuestionColor]:
	return qst_clr
