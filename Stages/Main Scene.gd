extends Control


<<<<<<< Updated upstream:GUI and Stage/Main Scene.gd
=======
var next_scene = preload("res://Stages/Stage1.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass 

>>>>>>> Stashed changes:Stages/Main Scene.gd
func _goto_next_level():
	get_tree().change_scene("res://GUI and Stage/Stage1.tscn")

func _on_Start_pressed():
	_goto_next_level();

func _on_Exit_pressed():
	get_tree().quit()