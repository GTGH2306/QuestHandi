extends Label
var dice: int = -1
var dice2: int = -1


func _on_dice_dice_landed(value: int) -> void:
	dice = value
	show_result()

func _on_dice_2_dice_landed(value: int) -> void:
	dice2 = value
	show_result()

func show_result():
	if(dice > 0 && dice2 > 0):
		text = str('Total: ', dice + dice2)
		print(dice + dice2)
