extends GutTest
## Ici je ne suis pas d'accord pour cette classe de test.
##
## En effet, QuestionList est un "wrapper" simple de liste car je souhaitais mettre une liste de questions dans un dictionnaire.
## Hors, tester ce wrapper revient trop directement à tester le composant Array fournit par Godot.
## C'est une mauvaise pratique de "tester le framework".

var qlist: QuestionList

func before_each() -> void:
	qlist = QuestionList.new()

func after_each() -> void:
	qlist = null

func test_list_is_empty_at_init() -> void:
	assert_eq(qlist.qstList.size(), 0)

func test_add_question() -> void:
	var q = Question.new()
	var line: Array[String] = ["Question ?", "Réponse", ""]
	q.initialize(line)
	qlist.qstList.append(q)
	assert_eq(qlist.qstList.size(), 1)

func test_add_multiple_questions() -> void:
	for i in range(3):
		var q = Question.new()
		var line: Array[String] = ["Question %d ?" % i, "Réponse %d" % i, ""]
		q.initialize(line)
		qlist.qstList.append(q)
	assert_eq(qlist.qstList.size(), 3)

func test_retrieve_question_by_index() -> void:
	var q = Question.new()
	var line: Array[String] = ["Qu'est-ce que Godot ?", "Un moteur de jeu", ""]
	q.initialize(line)
	qlist.qstList.append(q)
	assert_eq(qlist.qstList[0].question, "Qu'est-ce que Godot ?")
	assert_eq(qlist.qstList[0].answer, "Un moteur de jeu")
