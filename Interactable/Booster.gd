# code owner : Hyoyeon Yu

extends Area2D

class_name Booster

# call if player is collide with Booster
func _on_Booster_body_entered(body):
	if body is PlayerManager:
	# reomve the object from the memory
		queue_free()

