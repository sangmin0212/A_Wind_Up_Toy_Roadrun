extends Area2D

class_name Battery

# 플레이어가 배터리와 닿으면
func _on_Battery_body_entered(body):
	# body not Monster
	if body is PlayerManager:
	# reomve the object from the memory
		queue_free()
