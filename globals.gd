extends Node

var rng : RandomNumberGenerator : 
	get:
		if random == null:
			random = RandomNumberGenerator.new()
		return random

var random : RandomNumberGenerator = null


enum clr {
	RED,
	GREEN,
	BLUE,
	ORANGE,
	PINK
}
var qst_clr:Dictionary[clr, QuestionColor] = {
	clr.BLUE: QuestionColor.new(Color.DEEP_SKY_BLUE, "Bleue"),
	clr.GREEN: QuestionColor.new(Color.LIME_GREEN, "Verte"),
	clr.ORANGE: QuestionColor.new(Color.GOLDENROD, "Orange"),
	clr.PINK: QuestionColor.new(Color.HOT_PINK, "Rose"),
	clr.RED: QuestionColor.new(Color.RED, "Rouge")
}

func get_qst_clr() -> Dictionary[clr, QuestionColor]:
	return qst_clr
