extends RefCounted
class_name QuestionColor

var clr:Color
var name:String

func _init(_color: Color, _name: String) -> void:
	clr = _color
	name = _name
