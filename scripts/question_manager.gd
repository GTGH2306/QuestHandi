extends RefCounted
## Classe permettant le tirage de question selon le thème, en évitant que la même question ressorte plusieurs fois autant que possible
class_name QuestionManager

var questions: Dictionary[Globals.clr, QuestionList] = {
	Globals.clr.BLUE: QuestionList.new(),
	Globals.clr.GREEN: QuestionList.new(),
	Globals.clr.ORANGE: QuestionList.new(),
	Globals.clr.PINK: QuestionList.new(),
	Globals.clr.RED: QuestionList.new()
}

## Charge toutes les questions à l'initialisation
func _init():
	load_questions(Globals.clr.BLUE)
	load_questions(Globals.clr.GREEN)
	load_questions(Globals.clr.ORANGE)
	load_questions(Globals.clr.PINK)
	load_questions(Globals.clr.RED)

## Tire une question aléatoire et la supprime de la liste pour éviter qu'elle ne réapparaisse plus tard
func draw_question(question_clr: Globals.clr) -> Question:	
	var id:int = Globals.rng.randi_range(0, questions[question_clr].qstList.size() - 1)
	var result:Question = questions[question_clr].qstList[id]
	questions[question_clr].qstList.remove_at(id)
	
	if questions[question_clr].qstList.size() < 1:
		load_questions(question_clr)
	
	return result

## Charge les question pour une couleur de thème donné
func load_questions(clr : Globals.clr):
	questions[clr] = load_csv_to_question_array(FileManager.questions_paths[clr])

## Retourne une liste de questions à partir du chemin du CSV
func load_csv_to_question_array(csv_path: String) -> QuestionList:
	#Declaration de l'array resultat
	var result: QuestionList = QuestionList.new()
	#Charge le fichier en mode lecture
	var file = FileAccess.open(csv_path,FileAccess.READ)
	var lines: Array = []
	#Annule si aucun fichier trouver
	if file == null:
		printerr("No CSV found:", csv_path)
		return result
	#Conversion utf8
	var utf8: String = file.get_as_text()
	file.close()
	
	
	var raw = utf8.split("\n")
	#Itère sur chaque ligne du fichier
	var i = 1
	while i < raw.size():
		var cleaned_line: String = raw[i].strip_edges()
		lines.append(cleaned_line.split(';'))
		i += 1
	
	for line in lines:
		for j in range(line.size()):
			line[j] = line[j].strip_edges()
		if line.size() > 1:
			result.qstList.append(Question.new().initialize(line))
	return result
