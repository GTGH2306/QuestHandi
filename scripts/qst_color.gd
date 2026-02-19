extends RefCounted
class_name QuestionColor

var clr:Color
var name:String

func _init(c: Color, n: String) -> void:
	clr = c
	name = n
