extends Node2D


var wall_speed = 200


func _physics_process(delta):
	$WallPath/PathFollow2D.offset += wall_speed * delta
