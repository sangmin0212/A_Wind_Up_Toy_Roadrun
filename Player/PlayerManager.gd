extends KinematicBody2D

class_name PlayerManager

onready var gameManager = find_parent("GameManager")
var gameOver = false

# Move and Rotate
var velocity = Vector2(1,0)
var speed = 0
var speedInitial = 200
var speedMax = 400
var reflect_angle = 0
var isturn = false
var collisionTimer
var canCollision = true
var i = 0
# Item
var is_battery_work = true
var batteryTimer
var boosterTimer
var isBooster = false

onready var _animation_player = $AnimationPlayer
var state = "Stop"
var isGameEnded = false

func _ready():
	pass
	collisionTimer = create_timer("collision_cooltime", 0.1)

func game_start():
	speed = 200
	state = "Idle"
	
func stage_clear():
	speed = 0	
	isGameEnded = true
	
func game_over():
	speed = 0
	state = "Die"
	isGameEnded = true
	# 추가 : dead effect, dead sound

func isGameEnded():
	if isGameEnded:
		return true
	else:
		return false
	
func _physics_process(delta):
	# update animation
	if !gameOver:
		update_sprite()
		
	# player move itself
	if speed == 0:
		return
	velocity = velocity.normalized() * speed
	var collision = move_and_collide(velocity*delta)
	
	# turn the player based on reflect_angle
	if i < 5 and isturn:
		rotate(reflect_angle/5)
		i += 1
		if i == 5:
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
		# if reflect_angle is 3.14159...(180 degree) it didn't change well
		isturn = true
		# move base on bounce vector
		velocity = velocity.bounce(collision.normal)
		move_and_collide(reflect)
		
	
	# 1205 효연 추가
	speed -= 10 * delta
	
	if speed <= 0:
		print("Player died!!!")
		get_tree().paused = true
	
	if isBooster and speed > 200:
		speed -= 50 * delta
		if speed <= speedInitial:
			speed = speedInitial
			isBooster = false


func update_sprite():
	if _animation_player.get_current_animation() != state:
		_animation_player.play(state);
	if state == "Die":
		gameOver = true	
		
func collision_cooltime():
	canCollision = true

# make timer 
# https://godotengine.org/qa/46078/perhaps-a-second-timer
func create_timer (item_func, item_time) -> Timer:
	var timer = Timer.new()    
	add_child (timer)
	timer.set_wait_time (item_time)
	timer.connect("timeout", self, item_func)
	return timer

# 1205 효연 추가
func take_speed(amount):
	speed += amount
	if speed > speedMax:
		speed = speedMax
	print("player picked a battery! Current speed is: ", speed)


func _on_Battery_body_entered(body):
	take_speed(60)
	state = "Battery"
	yield(get_tree().create_timer(1),"timeout")
	state = "Idle" 

func _on_Booster_body_entered(body):
	isBooster = true
	speed = 400
	print("current speed: ", speed)
	print("player picked a booster!")
	state = "Booster"
	yield(get_tree().create_timer(1),"timeout")
	state = "Idle"

func _on_Bomb_body_entered(body):
	game_over()
