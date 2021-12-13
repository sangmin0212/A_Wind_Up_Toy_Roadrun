extends Node2D


var lastStage = 0
var gameAllClear = false
const stageClear = {"Stage1" : false, "Stage2" : false,"Stage3" : false,"Stage4" : false,"Stage5" : false,"Stage6" : false,}

func _exit():
	get_tree().quit()
	
func _load_scene(sceneName):
	get_tree().change_scene("res://Stage/"+sceneName+".tscn")

func _clear_stage(stage):
	stageClear[stage] = true

func is_stage_clear():
	for stage in stageClear:
		if stageClear[stage] == false:
			return gameAllClear
	gameAllClear = true
	return gameAllClear

func _input(event):
	if Input.is_action_pressed("ui_left"):
		for stage in stageClear:
			stageClear[stage] = true
	if Input.is_action_pressed("ui_right"):
		print(is_stage_clear())		
