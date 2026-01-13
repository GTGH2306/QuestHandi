extends Control
class_name QuestionMenu
signal question_answered

var team: Team

func initialize(team_answering: Team, question_clr: String) -> void:
	team = team_answering
	$Panel/Label.text = str("Question ", question_clr.to_upper(), " pour l'équipe ", team.team_name.to_upper())

func _on_option_button_item_selected(index: int) -> void:
	if index >= 0:
		$Panel/Button.disabled = false

func _on_button_pressed() -> void:
	if $Panel/OptionButton.selected == 0:
		question_answered.emit()
		team.last_response = true
	else:
		question_answered.emit()
		team.last_response = false
	$".".queue_free()
