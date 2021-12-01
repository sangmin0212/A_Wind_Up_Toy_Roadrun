extends KinematicBody2D

class_name PlayerManager

onready var gameManager = find_parent("GameManager")

# Move and Rotate
var velocity = Vector2(1,0)
var speed = 0
var reflect_angle = 0
var isturn = false
var collisionTimer
var canCollision = true
var i = 0
# Item
var is_battery_work = true
var batteryTimer
var boosterTimer


func _init(_position = Vector2(0,0)):
	position = _position

func _ready():
	# set timer. After 10 second, player's speed will be decreased
	collisionTimer = create_timer("collision_cooltime", 0.1)
	batteryTimer = create_timer("battery_cooltime",10)
	boosterTimer = create_timer("booster_cooltime", 5)

func game_start():
	speed = 200
	batteryTimer.set_wait_time(10)
	batteryTimer.start()

func game_over():
	speed = 0
	# 추가 : dead effect, dead sound

func _physics_process(delta):
	# player move itself
	if speed == 0:
		return
	velocity = velocity.normalized() * speed
	var collision = move_and_collide(velocity*delta)

	# turn the player based on reflect_angle
	if i < 10 and isturn:
		rotate(reflect_angle/10)
		i += 1
		if i == 10:
			i = 0
			isturn = false
	
	# if wind-up toy collide with wall, change move direction
	# 추가 : reflect sound 
	if collision and canCollision:
		collisionTimer.start()
		canCollision = false
		var reflect = collision.remainder.bounce(collision.normal)
		# calculate reflect_angle(using 2 vector). using rotate in _physics_process for rotate smootly
		reflect_angle = velocity.angle_to(reflect)
		print(reflect_angle)
		# if reflect_angle is 3.14159...(180 degree) it didn't change well
		isturn = true
		# move base on bounce vector
		velocity = velocity.bounce(collision.normal)
		move_and_collide(reflect)
		
	# speed will be decreased if you want to charge it, eat battery	
	if !is_battery_work and speed >= 0:
		# 추가 : battery low sound
		speed -= 2
		if speed <= 0:
			speed = 0

func collision_cooltime():
	canCollision = true
	
# Item
func battery():
	# 추가 : baatery sound
	is_battery_work = true
	speed = 200	
	batteryTimer.start()

func booster():
	# 추가 : booster sound
	speed = 400
	boosterTimer.set_wait_time(5)
	boosterTimer.start()

# Item timer
func battery_cooltime():
	print("The battery is dead!")
	is_battery_work = false
	
func booster_cooltime():
	speed = 200

# make timer 
# https://godotengine.org/qa/46078/perhaps-a-second-timer
func create_timer (item_func, item_time) -> Timer:
	var timer = Timer.new()    
	add_child (timer)
	timer.set_wait_time (item_time)
	timer.connect("timeout", self, item_func)
	return timer
	
#임시 치트키
func _input(event):
	if Input.is_action_pressed("ui_up"):
			battery()
	if Input.is_action_pressed("ui_down"):
			booster()
