extends Control
## Carte question affichée à l'écran
class_name QuestionMenu
signal question_answered

var team: Team

## Indique quel équipe répond à la question
func initialize(team_answering: Team, question_clr: String) -> void:
	team = team_answering
	$Panel/Label.text = str("Question ", question_clr.to_upper(), " pour l'équipe ", team.team_name.to_upper())

## Le bouton est désactivé tant que le formateur n'as pas sélectionné si l'équipe à répondu juste
func _on_option_button_item_selected(index: int) -> void:
	if index >= 0:
		$Panel/Button.disabled = false

## Lorsque la réponse est validé, un signal est émi et on indique si la réponse de l'équipe est juste ou non et ôte la carte
func _on_button_pressed() -> void:
	team.last_response = $Panel/OptionButton.selected == 0
	question_answered.emit()
	$".".queue_free()
