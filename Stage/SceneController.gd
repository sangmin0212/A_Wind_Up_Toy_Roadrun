# 
extends Node2D


var lastStage = 0
var gameAllClear = false

const stageClear = {
	"Stage1" : true, 
	"Stage2" : false,
	"Stage3" : false,
	"Stage4" : false,
	"Stage5" : false,
	"Stage6" : false,}

onready var background_sound = $BackgroundSound

# play background music
func _ready():
	if background_sound != null:
		background_sound.play()

# game over
func _exit():
	get_tree().quit()

# load another scene	
func _load_scene(sceneName):
	get_tree().change_scene("res://Stage/"+sceneName+".tscn")

# mark stage clear
func _clear_stage(stage):
	stageClear[stage] = true
	for stage in stageClear:
		print(stage)
		print(stageClear[stage])

# return is all game stage is cleared or not
func is_stage_clear():
	for stage in stageClear:
		if stageClear[stage] == false:
			return gameAllClear
	gameAllClear = true
	return gameAllClear
