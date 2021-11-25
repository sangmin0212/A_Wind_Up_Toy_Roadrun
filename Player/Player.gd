extends KinematicBody2D

class_name player

var velocity = Vector2(1,0)
var speed = 200
var isturn = false
var i = 0
#var rotation_speed = PI/64
#var rotation_direction = 1
#var turnLeft = false
#var turnRight = false
#var turnNum = 0

var life = 3

func _physics_process(delta):
	# player move itself

	velocity = velocity.normalized() * speed
	var collision = move_and_collide(velocity*delta)

	#look_at(get_global_mouse_position())
	if isturn and i < 18:
		rotation_degrees += 5
		i+= 1
		
	# if wind-up toy collide with wall, change move direction
	if collision:
		var reflect = collision.remainder.bounce(collision.normal)
		velocity = velocity.bounce(collision.normal)
		print(reflect)
		
		# reflect 백터값 파악해서 tureleft, turnright할지 결정하기
		# rotation_direction = left : -1, right : 1
		# rotation_speed(PI)를 점점 더해야 겠다.		
		move_and_collide(reflect)
		isturn = true
		i = 0
		
	# speed will be decreased if you want to charge it, eat battery	
	if speed > 0:
		speed -= 0.2

##func determineTurn(direction):
#	if direction.x >= -0.25 and direction.x <= 0.25 and direction.y >= -0.25 and direction.y <= 0.25:
#		return 1
#	if direction.x >= 0.25 and direction.x <= 0.75 and direction.y >= 0.25 and direction.y <= 0.75:
#		return 2
#	if direction.x >= 0.5 and direction.x <= 0.25 and direction.y >= -0.25 and direction.y <= 0.25:
#		return 3
#	if direction.x >= -0.25 and direction.x <= 0.25 and direction.y >= -0.25 and direction.y <= 0.25:
#		return 4
#	if direction.x >= -0.25 and direction.x <= 0.25 and direction.y >= -0.25 and direction.y <= 0.25:
#		return 5
#	if direction.x >= -0.25 and direction.x <= 0.25 and direction.y >= -0.25 and direction.y <= 0.25:
#		return 6
#	if direction.x >= -0.25 and direction.x <= 0.25 and direction.y >= -0.25 and direction.y <= 0.25:
#		return 7
#	if direction.x >= -0.25 and direction.x <= 0.25 and direction.y >= -0.25 and direction.y <= 0.25:
#		return 8
		
