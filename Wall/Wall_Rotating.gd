extends StaticBody2D


func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	rotate(PI/4 * delta)
