# code owner : Sangmin Oh

extends Node2D

var wall_speed = 200

# move wall itself
func _physics_process(delta):
	$WallPath/PathFollow2D.offset += wall_speed * delta
