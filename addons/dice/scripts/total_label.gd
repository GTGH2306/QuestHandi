extends Label
var dice: int = -1
var dice2: int = -1


func _on_dice_dice_landed(value: int) -> void:
	dice = value
	showResult()

func _on_dice_2_dice_landed(value: int) -> void:
	dice2 = value
	showResult()

func showResult():
	if(dice > 0 && dice2 > 0):
		text = str('Total: ', dice + dice2)
		print(dice + dice2)
