extends Node2D

var wall_node = load("res://Wall/DrawingWall.tscn")
var walls = []

export (int) var wallWidth = 10
export (int) var wallLimit = 10
export (int) var wallLengthLimit = 150

var isClicked = false
var isCreated = false

var startPoint = Vector2()
var endPoint = Vector2()

func _input(event):
	if event is InputEventScreenTouch:
		if  !isClicked  and event.pressed == true:
			isClicked = true
			startPoint = get_canvas_transform().xform_inv(event.position)
			print("left click press")
		elif isClicked and event.pressed == false:
			isClicked = false
			isCreated = false
			endPoint = get_canvas_transform().xform_inv(event.position)
			walls[-1].enable_collision()
			print("left click unpress")
	
	if event is InputEventScreenDrag:
		endPoint = get_canvas_transform().xform_inv(event.position)

func _process(_delta):
	
	
	var tempWall
	if(isClicked and !isCreated and walls.size() < wallLimit):
		print("create wall")
		tempWall = wall_node.instance()
		add_child(tempWall)
		walls.append(tempWall)
		isCreated = true
	
	if(isClicked and isCreated):
		if((endPoint-startPoint).length() > wallLengthLimit):
			endPoint = startPoint + (endPoint-startPoint).normalized() * wallLengthLimit
		walls[-1].update_points(startPoint, endPoint, wallWidth)

