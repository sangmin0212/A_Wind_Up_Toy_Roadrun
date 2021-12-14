# code owner : Hyoyeon Yu

extends Area2D

class_name Bomb

# call if player is collide with Bomb
func _on_Bomb_body_entered(body):
	# body not Monster
	if body is PlayerManager:
		queue_free()
		

