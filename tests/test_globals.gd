extends GutTest

func test_rng_is_initialized() -> void:
	var rng = Globals.rng
	assert_not_null(rng)

func test_rng_lazy_init_returns_same_instance() -> void:
	var rng1 = Globals.rng
	var rng2 = Globals.rng
	assert_eq(rng1, rng2)

func test_qst_clr_contains_five_colors() -> void:
	var colors = Globals.qst_clr
	assert_eq(colors.size(), 5)

func test_qst_clr_has_all_enum_keys() -> void:
	var colors = Globals.qst_clr
	assert_true(colors.has(Globals.clr.RED))
	assert_true(colors.has(Globals.clr.GREEN))
	assert_true(colors.has(Globals.clr.BLUE))
	assert_true(colors.has(Globals.clr.ORANGE))
	assert_true(colors.has(Globals.clr.PINK))

func test_each_color_has_non_empty_name() -> void:
	var colors = Globals.qst_clr
	for key in colors.keys():
		var entry: QuestionColor = colors[key]
		assert_ne(entry.name, "", "Le nom de la couleur %s ne doit pas être vide" % key)

func test_get_qst_clr_returns_same_dict() -> void:
	var result = Globals.get_qst_clr()
	assert_eq(result, Globals.qst_clr)

func test_clr_enum_has_five_values() -> void:
	assert_eq(Globals.clr.keys().size(), 5)
