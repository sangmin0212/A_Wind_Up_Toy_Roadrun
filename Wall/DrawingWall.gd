extends StaticBody2D

var points = []
onready var player = get_parent().get_parent().get_node("Player")

func update_points(start, end, width):
	points.clear()
	points.append(start + (end - start).rotated(PI/2).normalized() * width)
	points.append(start - (end - start).rotated(PI/2).normalized() * width)
	points.append(end - (end - start).rotated(PI/2).normalized() * width)
	points.append(end + (end - start).rotated(PI/2).normalized() * width)
	get_node("Polygon2D").set_polygon(points)
	get_node("OuterCollisionPolygon2D").set_polygon(points)
	
	var center = Vector2(0,0)
	for i in range(4):
		center += points[i]
	center /= 4
	for i in range(4):
		points[i] = center + (points[i] - center) * 0.8
	get_node("Area2D").get_node("InnerCollisionPolygon2D").set_polygon(points)

# when release mouse
func enable_collision():
	get_node("OuterCollisionPolygon2D").disabled = false
	
func _on_Area2D_body_exited(body):
	if(body.name == player.name):
		print("overlap end")
		get_node("OuterCollisionPolygon2D").disabled = false

func _on_Area2D_body_entered(body):
	if(body.name == player.name):
		print("overlap start")
		get_node("OuterCollisionPolygon2D").disabled = true
