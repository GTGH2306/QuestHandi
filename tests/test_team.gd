extends GutTest

var team: Team

func before_each() -> void:
	team = Team.new(Pawn.Model.BASE, "EquipeTest")
	add_child_autofree(team)

func test_team_name_is_assigned() -> void:
	assert_eq(team.team_name, "EquipeTest")

func test_square_pos_starts_at_zero() -> void:
	assert_eq(team.square_pos, 0)

func test_last_response_starts_true() -> void:
	assert_true(team.last_response)

func test_move_left_starts_at_zero() -> void:
	assert_eq(team.move_left, 0)

func test_move_to_sets_target_transform() -> void:
	var new_pos := Vector3(1.0, 0.0, 1.0)
	var new_rot := Vector3(0.0, 0.0, 0.0)
	team.move_to(new_pos, new_rot)
	assert_not_null(team.target_transform)

func test_move_to_resets_move_progress() -> void:
	team.move_progress = 0.9
	team.move_to(Vector3(2.0, 0.0, 2.0), Vector3.ZERO)
	assert_eq(team.move_progress, 0.0)

func test_team_pawn_is_not_null() -> void:
	assert_not_null(team.team_pawn)
