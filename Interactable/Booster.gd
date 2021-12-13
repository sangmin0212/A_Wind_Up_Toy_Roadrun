extends Area2D

class_name Booster

# 플레이어가 부스터와 닿으면
func _on_Booster_body_entered(body):
	# body not Monster
	if body is PlayerManager:
	# reomve the object from the memory
		queue_free()

