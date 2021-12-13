#extends Node2D
#
#
#var wall_node = load("res://Wall/DrawingWall.tscn")
#var walls = []
#
#export (int) var wallWidth = 10
#export (int) var wallLimit = 10
#export (int) var wallLengthLimit = 150
#export (int) var WallCreatingTime = 1.5
#
#var isClicked = false
#var isCreated = false
#var isPossibleToMakeWall = true
#
#var startPoint = Vector2()
#var endPoint = Vector2()
#
#onready var wall_timer = get_tree().get_node("IngameGUI")
#var wallCreatingTimer
#onready var progressTimer
#
#
#func _ready():
#	var temp
#	temp = wall_timer.instance()
#	add_child(temp)
#	progressTimer = get_node("IngameGUI").get_node("TextureProgress")
#	wallCreatingTimer = create_timer("wallCreatingTimer",WallCreatingTime)
#
#func create_timer (item_func, item_time) -> Timer:
#	var timer = Timer.new()    
#	add_child (timer)
#	timer.set_wait_time (item_time)
#	timer.connect("timeout", self, item_func)
#	return timer
#
#func wallCreatingTimer():
#	isPossibleToMakeWall = true
#
#func _input(event):
#	if event is InputEventScreenTouch:
#		if  !isClicked  and event.pressed == true:
#			isClicked = true
#			startPoint = get_canvas_transform().xform_inv(event.position)
#			print("left click press")
#		elif isClicked and event.pressed == false:
#			isClicked = false
#			isCreated = false
#			endPoint = get_canvas_transform().xform_inv(event.position)
#			walls[-1].enable_collision()
#			print("left click unpress")
#
#	if event is InputEventScreenDrag:
#		endPoint = get_canvas_transform().xform_inv(event.position)
#
#func _process(_delta):
#	if isPossibleToMakeWall:
#		progressTimer.value = 0
#	else:
#		if(wallLimit > walls.size()):
#			progressTimer.value += 1/WallCreatingTime * 100 * _delta
#
#	var tempWall
#	if(isClicked and !isCreated and walls.size() < wallLimit):
#		print("create wall")
#		tempWall = wall_node.instance()
#		add_child(tempWall)
#		walls.append(tempWall)
#		isCreated = true
#
#	if(isClicked and isCreated):
#		if((endPoint-startPoint).length() > wallLengthLimit):
#			endPoint = startPoint + (endPoint-startPoint).normalized() * wallLengthLimit
#		walls[-1].update_points(startPoint, endPoint, wallWidth)
#
