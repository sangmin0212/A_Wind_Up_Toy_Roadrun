extends Control


func _goto_next_level():
	get_tree().change_scene("res://Stage/Stage1.tscn")

func _on_Start_pressed():
	_goto_next_level();

func _on_Exit_pressed():
	get_tree().quit()


func _on_Start_button_up():
	pass # Replace with function body.
