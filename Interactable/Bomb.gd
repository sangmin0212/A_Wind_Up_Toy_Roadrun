extends Area2D

class_name Bomb
# 플레이어가 폭탄과 닿으면
func _on_Bomb_body_entered(body):
	# body not Monster
	if body is PlayerManager:
		queue_free()
		

