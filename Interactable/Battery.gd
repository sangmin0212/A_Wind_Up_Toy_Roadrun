extends Area2D

class_name Battery

# 플레이어가 배터리와 닿으면
func _on_Battery_body_entered(body):
	if body is PlayerManager:
		queue_free()
