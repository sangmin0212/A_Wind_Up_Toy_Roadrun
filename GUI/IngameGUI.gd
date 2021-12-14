# code owner : Minho Jeong

extends Node

var sceneController
var player
var speedProgressBar
var wallNum = []

func _ready():
	player = get_parent().get_node("GameManager").get_node("Player")
	speedProgressBar = get_node("TextureProgress2")
	sceneController = get_parent().get_node("SceneController")

# Set wall limit UI
func setWallLimitUI(num):
	for i in range(4):
		wallNum.append(get_node(str(i)))
	for i in wallNum:
		i.hide()
	if num < 10:
		get_node("Infinite").hide()
		wallNum[num].show()

# Change UI of remain walls
func changeWallNumSprite(num):
	wallNum[num+1].hide()
	wallNum[num].show()

# Pause game
func _on_PauseButton_toggled(button_pressed):
	if button_pressed:
		get_tree().paused = true
	else:
		get_tree().paused = false

# Set progress bar of wall creating wait time
func setProgressValue(value):
	get_node("TextureProgress").value = value

func _process(delta):
	var temp =  player.getSpeed()
	if temp >= 200:
		speedProgressBar.value = 100
	else:
		speedProgressBar.value = temp/ 200 * 100

func _on_Home_pressed():
	sceneController._load_scene("Main Scene")


func _on_Retry_pressed():
	sceneController._load_scene(get_parent().to_string())
