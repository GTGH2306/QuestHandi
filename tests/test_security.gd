extends GutTest


func test_question_initialize_with_empty_array_does_not_crash() -> void:
	var q = Question.new()
	var line: Array[String] = []
	var result = q.initialize(line)
	assert_null(result)
	assert_push_error("Le format de la question ne correspond pas à ce qui est attendu.")


func test_question_initialize_with_one_column_does_not_crash() -> void:
	var q = Question.new()
	var line: Array[String] = ["Une seule colonne"]
	var result = q.initialize(line)
	assert_null(result)
	assert_push_error("Le format de la question ne correspond pas à ce qui est attendu.")


func test_question_initialize_with_five_columns_does_not_crash() -> void:
	var q = Question.new()
	var line: Array[String] = ["col1", "col2", "col3", "col4", "col5"]
	var result = q.initialize(line)
	assert_null(result)
	assert_push_error("Le format de la question ne correspond pas à ce qui est attendu.")


func test_question_list_can_add_null() -> void:
	var qlist = QuestionList.new()
	qlist.qstList.append(null)
	assert_eq(qlist.qstList.size(), 1)
	assert_null(qlist.qstList[0])

func test_clr_enum_has_exactly_five_values() -> void:
	assert_eq(Globals.clr.keys().size(), 5)

func test_file_manager_paths_cover_all_colors() -> void:
	var paths = FileManager.questions_paths
	assert_true(paths.has(Globals.clr.RED))
	assert_true(paths.has(Globals.clr.GREEN))
	assert_true(paths.has(Globals.clr.BLUE))
	assert_true(paths.has(Globals.clr.ORANGE))
	assert_true(paths.has(Globals.clr.PINK))
	assert_eq(paths.size(), 5)

func test_file_manager_paths_are_non_empty_strings() -> void:
	var paths = FileManager.questions_paths
	for key in paths.keys():
		assert_ne(paths[key], "", "Le chemin pour la couleur %s ne doit pas être vide" % key)

func test_question_color_name_never_empty_in_globals() -> void:
	for key in Globals.qst_clr.keys():
		var entry: QuestionColor = Globals.qst_clr[key]
		assert_ne(entry.name, "")
