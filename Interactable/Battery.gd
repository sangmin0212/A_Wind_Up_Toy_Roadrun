# code owner : Hyoyeon Yu

extends Area2D

class_name Battery

# call if player is collide with Battery
func _on_Battery_body_entered(body):
	if body is PlayerManager:
	# reomve the object from the memory
		queue_free()
