extends Area2D

# 다음 스테이지로 넘어가려면 end point에서 Stage3, 4, 5.. 미리 지정하기
var next_scene = preload("res://GUI and Stage/Stage2.tscn")
onready var next_stage_button = get_parent().get_node("NextStageButton")

# 현재 씬 이름
# var scene_name = get_tree().get_current_scene().get_name()



func _on_EndPoint_body_entered(body):
		# print(scene_name)
	if body is PlayerManager:
		next_stage_button.visible = true
		next_stage_button.get_child(0).play("appear")

func _on_TextureButton_pressed():
	get_tree().change_scene("res://GUI and Stage/Stage2.tscn")
