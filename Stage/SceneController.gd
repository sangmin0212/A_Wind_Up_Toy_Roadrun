extends Node2D


var lastStage = 0
var gameAllClear = false
const stageClear = {"Stage1" : true, "Stage2" : false,"Stage3" : false,"Stage4" : false,"Stage5" : false,"Stage6" : false,}
onready var audio_player = $BackgroundSound

func _ready():
	if audio_player != null:
		audio_player.play()

func _exit():
	get_tree().quit()
	
func _load_scene(sceneName):
	get_tree().change_scene("res://Stage/"+sceneName+".tscn")

func _clear_stage(stage):
	stageClear[stage] = true
	for stage in stageClear:
		print(stage)
		print(stageClear[stage])

func is_stage_clear():
	for stage in stageClear:
		if stageClear[stage] == false:
			return gameAllClear
	gameAllClear = true
	return gameAllClear



func _stage_clear(extra_arg_0):
	pass # Replace with function body.


func _on_Option_pressed():
	pass # Replace with function body.


func _on_Back_pressed():
	pass # Replace with function body.
