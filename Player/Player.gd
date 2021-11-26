extends KinematicBody2D

class_name player

# move
var velocity = Vector2(1,0)
var speed = 200
# rotate
var reflect_angle = 0
var isturn = false
var i = 0
# life
var life = 3

func _physics_process(delta):
	# player move itself
	velocity = velocity.normalized() * speed
	var collision = move_and_collide(velocity*delta)

	# turn the player based on reflect_angle
	if i < 10 and isturn:
		print(reflect_angle)
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
	# 5초 정도는 full charging으로 갈 수 있게
	if speed > 0:
		speed -= 0.2
