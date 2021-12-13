extends Node


var sceneController

func _ready():
	sceneController = get_parent().get_node("SceneController")

func _on_PauseButton_toggled(button_pressed):
	if button_pressed:
		get_tree().paused = true
	else:
		get_tree().paused = false

func setProgressValue(value):
	get_node("TextureProgress").value = value
	

