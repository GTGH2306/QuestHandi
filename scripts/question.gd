extends RefCounted
class_name Question

var question : String
var answer : String
var img_name : String

## Initialise un objet question à partir d'un tableau au format attendu[/br]
## Format attendu: ["question", "réponse", "nom de l'image (chaîne vide si aucune)"]
func initialize(csv_line: Array[String]) -> Question:
	if csv_line.size() < 2 or csv_line.size() > 3:
		push_error("Le format de la question ne correspond pas à ce qui est attendu.")
		return
	question = csv_line[0]
	answer = csv_line[1]
	if csv_line[2] != "":
		img_name = csv_line[2]
	return self
