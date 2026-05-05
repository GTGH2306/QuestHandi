extends Panel
class_name QuestionCard
signal question_answered(result: bool)
var style = preload("res://panel_style_box_flat.tres")


func _on_show_answer_pressed() -> void:
	$MarginContainer/VBoxContainer/ShowAnswer.visible = false
	$MarginContainer/VBoxContainer/Reponse.visible = true
	$MarginContainer/VBoxContainer/TrueFalseSelect.visible = true
	$MarginContainer/VBoxContainer/Validate.visible = true
	$MarginContainer/VBoxContainer/HSeparator3.visible = true


func _on_option_button_item_selected(_index: int) -> void:
	$MarginContainer/VBoxContainer/Validate.disabled = false

func initialize(question: Question, clr: Globals.clr, team: Team):
	#Change couleur de bordure	
	style.border_color = Globals.qst_clr[clr].clr
	add_theme_stylebox_override("panel", style)
	
	
	#Changement du titre
	$MarginContainer/TitleFlow/Title.text = str("Question ", Globals.qst_clr[clr].name, " pour l'équipe ", team.team_name)
	#Changement de la question
	$MarginContainer/VBoxContainer/Question.text = question.question
	#Changement de l'image
	if question.img_name != null && question.img_name != "":
		var image_path := FileManager.path_images.path_join(question.img_name)
		var img : Image = Image.new()
		var err : Error = img.load(image_path)
		if err == OK:
			var texture := ImageTexture.create_from_image(img)
			var textrect : TextureRect = $MarginContainer/VBoxContainer/MarginContainer/Image
			textrect.texture = texture
		else:
			printerr(str("Impossible de charger l'image: "),image_path )

	else:
		$MarginContainer/VBoxContainer/MarginContainer/Image.visible = false
	#Changement de la réponse
	$MarginContainer/VBoxContainer/Reponse.text = question.answer
	


func _on_validate_pressed() -> void:
	question_answered.emit($MarginContainer/VBoxContainer/TrueFalseSelect/OptionButton.selected == 1)
	$".".queue_free()
