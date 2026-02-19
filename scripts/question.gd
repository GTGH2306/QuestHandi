extends RefCounted
class_name Question

var question : String
var answer : String
var img_name : String

func initialize(csv_line: Array[String]) -> Question:
	question = csv_line[0]
	answer = csv_line[1]
	if csv_line[2] != "":
		img_name = csv_line[2]
	return self
