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

var wallCreatingTimer
var isPossibleToMakeWall = true

func _ready():
	wallCreatingTimer = create_timer("wallCreatingTimer",1.5)

func create_timer (item_func, item_time) -> Timer:
	var timer = Timer.new()    
	add_child (timer)
	timer.set_wait_time (item_time)
	timer.connect("timeout", self, item_func)
	return timer
	
func wallCreatingTimer():
	isPossibleToMakeWall = true

func _input(event):
	if isPossibleToMakeWall:
		if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
			if  !isClicked  and event.pressed == true:
				isClicked = true
				startPoint = get_global_mouse_position()
				print("left click press")
			elif isClicked and event.pressed == false:
				wallCreatingTimer.start()
				isPossibleToMakeWall = false
				isClicked = false
				isCreated = false
				endPoint = get_global_mouse_position()
				walls[-1].enable_collision()
				print("left click unpress")

func _process(_delta):
	var tempWall
	if(isClicked and !isCreated and walls.size() < wallLimit):
		print("create wall")
		tempWall = wall_node.instance()
		add_child(tempWall)
		walls.append(tempWall)
		isCreated = true
	
	if(isClicked and isCreated):
		endPoint = get_global_mouse_position()
		if((endPoint-startPoint).length() > wallLengthLimit):
			endPoint = startPoint + (endPoint-startPoint).normalized() * wallLengthLimit
		walls[-1].update_points(startPoint, endPoint, wallWidth)

