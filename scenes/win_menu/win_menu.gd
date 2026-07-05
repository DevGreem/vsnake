extends CenterContainer

class_name WinMenuNode

@onready var label: Label = $Container/Label

func win(player_id: int) -> void:
	show()
	
	if player_id == -1:
		label.text = "Tie!"
		return
	
	label.text = label.text.format([player_id+1])
