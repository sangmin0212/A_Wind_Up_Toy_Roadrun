# code owner : Sangmin Oh

extends StaticBody2D

# rotate wall itself
func _physics_process(delta):
	rotate(PI/4 * delta)

