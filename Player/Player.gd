extends KinematicBody2D

class_name player

# move
var velocity = Vector2(1,0)
var speed = 200
# rotate
var reflect_angle = 0
var isturn = false
var i = 0
# battery and life
var is_battery_work = true
var life = 3
var timer

func _ready():
	# set timer. After 10 second, player's speed will be decreased
	timer= Timer.new()
	add_child(timer)
	timer.connect("timeout",self,"_on_timeout")
	timer.set_wait_time(10)
	timer.start()


func _physics_process(delta):
	# player move itself
	velocity = velocity.normalized() * speed
	var collision = move_and_collide(velocity*delta)

	# turn the player based on reflect_angle
	if i < 10 and isturn:
		rotate(reflect_angle)
		i += 1
		if i == 10:
			i = 0
			isturn = false
	
	# if wind-up toy collide with wall, change move direction
	if collision:
		var reflect = collision.remainder.bounce(collision.normal)
		# calculate reflect_angle(using 2 vector). using rotate in _physics_process for rotate smootly
		reflect_angle = velocity.angle_to(reflect)
		reflect_angle = reflect_angle/10
		isturn = true
		# move base on bounce vector
		velocity = velocity.bounce(collision.normal)
		move_and_collide(reflect)
		
	# speed will be decreased if you want to charge it, eat battery	
	if !is_battery_work and speed >= 0:
		speed -= 1
		
func charge():
	timer.start()
	is_battery_work = true
	speed = 200	

func _on_timeout():
	print("The battery is dead!")
	is_battery_work = false

#임시 코드 for battery charging
func _input(event):
	if Input.is_action_pressed("ui_up"):
			charge()
			
