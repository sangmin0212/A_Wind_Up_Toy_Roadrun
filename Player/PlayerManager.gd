# code owner : Sangmin Oh
# sub code owner : Hyoyeon yu (control player speed, item)

extends KinematicBody2D

class_name PlayerManager

onready var gameManager = find_parent("GameManager")
var gameOver = false

# Move
var velocity
var speed = 0
var speedInitial = 200
var speedMax = 400

# Rotation
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

# Animation
onready var _animation_player = $AnimationPlayer
var state = "Stop"
var isGameEnded = false

# Sound
onready var reflectSound = $reflectSound
onready var deadSound = $DeadSound
onready var batterySound = $BatterySound
onready var boosterSound = $BoosterSound
onready var bombSound = $BombSound


func getSpeed():
	return speed

func _ready():
	# set first direction using player rotation
	velocity = Vector2(cos(rotation),sin(rotation))
	collisionTimer = create_timer("collision_cooltime", 0.1)

func game_start():
	speed = 200
	state = "Idle"
	
func stage_clear():
	speed = 0	
	isGameEnded = true

# call it when GameManager.game_over()
func game_over():
	if !deadSound.is_playing():
		deadSound.play()
	speed = 0
	state = "Die"
	isGameEnded = true

func isGameEnded():
	if isGameEnded:
		return true
	else:
		return false
	
func _physics_process(delta):
	# update animation
	if !gameOver:
		update_animation()
		
	# makes the player move on his own.
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
	if collision and canCollision:
		collisionTimer.start()
		reflectSound.play()
		canCollision = false
		isturn = true

		var reflect = collision.remainder.bounce(collision.normal)
		# calculate reflect_angle(using 2 vector). using rotate in _physics_process for rotate smootly
		reflect_angle = velocity.angle_to(reflect)
		velocity = velocity.bounce(collision.normal)
		move_and_collide(reflect)
		
	
	# speed will be decreased automatically
	speed -= 10 * delta
	
	# if speed == 0, player, determined that the player is dead.
	if speed <= 0:
		print("Player died!!!")
		get_tree().paused = true
	
	# If collide with booster, decrease speed until it returns to 200.
	if isBooster and speed > 200:
		speed -= 50 * delta
		if speed <= speedInitial:
			speed = speedInitial
			isBooster = false

# update animation based on player state
func update_animation():
	if _animation_player.get_current_animation() != state:
		_animation_player.play(state);
	if state == "Die":
		gameOver = true	
		
# To prevent it from hitting again while rotating, hit it every 0.1 second. 
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

# charge speed
func take_speed(amount):
	speed += amount
	if speed > speedMax:
		speed = speedMax
	print("player picked a battery! Current speed is: ", speed)

# charge 60 speed
func _on_Battery_body_entered(body):
	if !batterySound.is_playing():
		batterySound.play()
	take_speed(60)
	state = "Battery"
	yield(get_tree().create_timer(1),"timeout")
	state = "Idle" 
	
# charge speed to 400
func _on_Booster_body_entered(body):
	if !boosterSound.is_playing():
		boosterSound.play()	
	isBooster = true
	speed = 400
	print("current speed: ", speed)
	print("player picked a booster!")
	state = "Booster"
	yield(get_tree().create_timer(1),"timeout")
	state = "Idle"
	
# game over if player collide with bomb
func _on_Bomb_body_entered(body):
	game_over()
