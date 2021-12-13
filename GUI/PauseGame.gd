extends Container

onready var progress = get_node("TextureProgress")

func _on_Button_toggled(button_pressed):
	if button_pressed:
		get_tree().paused = true
	else:
		get_tree().paused = false

func fillTimer(value):
	progress += value
