extends Node2D


# 안에다가 파라미터 = 경로
func _main_scene():
	get_tree().change_scene("res://Stage/Main Scene.tscn")

func _game_story():
	get_tree().change_scene("res://Stage/GameStroy.tscn")

func _stage1():
	get_tree().change_scene("res://Stage/Stage1.tscn")

func _stage2():
	get_tree().change_scene("res://Stage/Stage2.tscn")

func _stage3():
	get_tree().change_scene("res://Stage/Stage3.tscn")	

func _credit():
	get_tree().change_scene("res://Stage/Credit.tscn")	

func _exit():
	get_tree().quit()
	
func _load_scene(sceneName):
	get_tree().change_scene("res://Stage/"+sceneName+".tscn")
