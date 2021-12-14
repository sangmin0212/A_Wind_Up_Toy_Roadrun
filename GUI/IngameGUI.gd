extends Node


var sceneController
var player
var speedProgressBar

func _ready():
#	sceneController = get_parent().get_node("SceneController")
	player = get_parent().get_node("GameManager").get_node("Player")
	speedProgressBar = get_node("TextureProgress2")

func _on_PauseButton_toggled(button_pressed):
	if button_pressed:
		get_tree().paused = true
	else:
		get_tree().paused = false

func setProgressValue(value):
	get_node("TextureProgress").value = value

func _process(delta):
	var temp =  player.getSpeed()
	if temp >= 200:
		speedProgressBar.value = 100
	else:
		speedProgressBar.value = temp/ 200 * 100

