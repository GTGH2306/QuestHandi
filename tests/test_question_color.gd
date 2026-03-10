extends GutTest

func test_initialize_stores_color() -> void:
	var qc = QuestionColor.new(Color.RED, "Rouge")
	assert_eq(qc.clr, Color.RED)

func test_initialize_stores_name() -> void:
	var qc = QuestionColor.new(Color.LIME_GREEN, "Verte")
	assert_eq(qc.name, "Verte")

func test_initialize_blue() -> void:
	var qc = QuestionColor.new(Color.DEEP_SKY_BLUE, "Bleue")
	assert_eq(qc.clr, Color.DEEP_SKY_BLUE)
	assert_eq(qc.name, "Bleue")

func test_initialize_orange() -> void:
	var qc = QuestionColor.new(Color.GOLDENROD, "Orange")
	assert_eq(qc.clr, Color.GOLDENROD)
	assert_eq(qc.name, "Orange")

func test_initialize_pink() -> void:
	var qc = QuestionColor.new(Color.HOT_PINK, "Rose")
	assert_eq(qc.clr, Color.HOT_PINK)
	assert_eq(qc.name, "Rose")

func test_name_not_empty() -> void:
	var qc = QuestionColor.new(Color.RED, "Rouge")
	assert_ne(qc.name, "")
