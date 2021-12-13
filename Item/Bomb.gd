extends Area2D

class_name Bomb

onready var audio_player = $AudioStreamPlayer

# 플레이어가 폭탄과 닿으면
func _on_Bomb_body_entered(body):
	# body not Monster
	if body is PlayerManager:
	# reomve the object from the memory
		# 게임 오버
		if !audio_player.is_playing():
			print("사운드재생")
			audio_player.play()	
		get_tree().paused = true
		print("player picked a bomb!")
		queue_free()
		
		
func _input(event):
	if Input.is_action_pressed("ui_down"):
			print("사운드재생")
			audio_player.play()	
