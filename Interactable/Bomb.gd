extends Area2D

class_name Bomb

onready var audio_player = $AudioStreamPlayer

# 플레이어가 폭탄과 닿으면
func _on_Bomb_body_entered(body):
	# body not Monster
	if body is PlayerManager:
	# reomve the object from the memory
		play_effect_sound()
		print("player picked a bomb!")
		yield(get_tree().create_timer(1),"timeout")
		queue_free()
		
func play_effect_sound():
	if !audio_player.is_playing():
		audio_player.play()
		

