extends GutTest

var question: Question

## Avant chaque test on créer une nouvelle question
func before_each() -> void:
	question = Question.new()

## Après chaque test on remet à zero la question
func after_each() -> void:
	question = null

## Cas nominal
func test_initialize_with_image() -> void:
	var line: Array[String] = ["Quelle est la couleur du ciel ?", "Bleu", "sky.png"]
	var result = question.initialize(line)
	assert_not_null(result)
	assert_eq(result.question, "Quelle est la couleur du ciel ?")
	assert_eq(result.answer, "Bleu")
	assert_eq(result.img_name, "sky.png")

## Cas sans image
func test_initialize_without_image() -> void:
	var line: Array[String] = ["Combien font 2 + 2 ?", "4", ""]
	var result = question.initialize(line)
	assert_not_null(result)
	assert_eq(result.question, "Combien font 2 + 2 ?")
	assert_eq(result.answer, "4")
	assert_eq(result.img_name, "")

## Cas avec colonne image manquante
func test_initialize_two_cols() -> void:
	var line: Array[String] = ["Combien font 2 + 2 ?", "4"]
	var result = question.initialize(line)
	assert_not_null(result)
	assert_eq(result.question, "Combien font 2 + 2 ?")
	assert_eq(result.answer, "4")
	assert_eq(result.img_name, "")

## Verifie que initialize() retourne bien la même question
func test_initialize_returns_self() -> void:
	var line: Array[String] = ["Question ?", "Réponse", ""]
	var result = question.initialize(line)
	assert_eq(result, question)

## Verifie que les champs sont assignés correctement
func test_fields_assigned_correctly() -> void:
	var line: Array[String] = ["Ma question", "Ma réponse", "image.png"]
	question.initialize(line)
	assert_eq(question.question, "Ma question")
	assert_eq(question.answer, "Ma réponse")
	assert_eq(question.img_name, "image.png")

## Verifie que ça ne fonctionne pas si il y'a trop peu de colonnes, et qu'une erreur est générée
func test_security_too_few_columns() -> void:
	var line: Array[String] = ["Une seule colonne"]
	var result = question.initialize(line)
	assert_null(result)
	assert_push_error("Le format de la question ne correspond pas à ce qui est attendu.")

## Verifie que ça ne fonctionne pas si il y'a trop de colonnes, et qu'une erreur est générée
func test_security_too_many_columns() -> void:
	var line: Array[String] = ["col1", "col2", "col3", "col4"]
	var result = question.initialize(line)
	assert_null(result)
	assert_push_error("Le format de la question ne correspond pas à ce qui est attendu.")
