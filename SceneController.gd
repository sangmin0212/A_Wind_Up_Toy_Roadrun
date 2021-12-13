extends Node2D


# 안에다가 파라미터 = 경로
func _main_scene():
	get_tree().change_scene("res://GUI and Stage/Main Scene.tscn")

func _game_story():
	get_tree().change_scene("res://GameStroy.tscn")

func _stage1():
	get_tree().change_scene("res://GUI and Stage/Stage1.tscn")

func _stage2():
	get_tree().change_scene("res://GUI and Stage/Stage2.tscn")

func _stage3():
	get_tree().change_scene("res://GUI and Stage/Stage3.tscn")	

func _credit():
	get_tree().change_scene("res://Credit.tscn")	

func _exit():
	get_tree().quit()
	
func _load_scene(sceneName):
	get_tree().change_scene("res://Stages/"+sceneName+".tscn")
