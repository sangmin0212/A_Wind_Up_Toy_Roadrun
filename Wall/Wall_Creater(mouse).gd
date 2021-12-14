# code owner : Minho Jeong

extends Node2D

var wall_node = load("res://Wall/DrawingWall.tscn")
var walls = []

export (int) var wallWidth = 5
export (int) var wallLimit = 10
export (int) var wallLengthLimit = 150
export (int) var WallCreatingTime = 1.5

var isClicked = false
var isCreated = false
var isPossibleToMakeWall = true

var startPoint = Vector2()
var endPoint = Vector2()

var wallCreatingTimer
var IngameGUI
var wallNum
var Player
var progressValue = 0

# Get other nodes and set wall limit cound UI
func _ready():
	IngameGUI = get_parent().get_parent().get_node("IngameGUI")
	Player = get_parent().get_node("Player")
	wallCreatingTimer = create_timer("wallCreatingTimer",WallCreatingTime)
	IngameGUI.setWallLimitUI(wallLimit)

func create_timer (item_func, item_time) -> Timer:
	var timer = Timer.new()    
	add_child (timer)
	timer.set_wait_time (item_time)
	timer.connect("timeout", self, item_func)
	return timer
	
func wallCreatingTimer():
	isPossibleToMakeWall = true

# Check if it is UI area
func isUIArea(pos):
	if pos.x >= 548 && pos.x <=761 && pos.y >=9 && pos.y <= 98:
		return true
	return false

# Get touch input(touch input is regarded as click input)
func _input(event):
	if !Player.isGameEnded():
		if isPossibleToMakeWall:
			if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
				if !isUIArea(get_global_mouse_position()):
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
						if wallLimit < 10:
							IngameGUI.changeWallNumSprite(wallLimit-walls.size())
						
						walls[-1].enable_collision()
						print("left click unpress")

# Drawing wall at every frame
func _process(_delta):
	if !Player.isGameEnded():
		if isPossibleToMakeWall:
			progressValue = 0
		else:
			if(wallLimit > walls.size()):
				progressValue += 1/WallCreatingTime * 100 * _delta
		IngameGUI.setProgressValue(progressValue)
		
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
