extends KinematicBody2D

class_name Monster

var isMonster = false
var hitPlayer = false
var target
var velocity = Vector2.ZERO
var speed = 300

signal hit_player()

	
func setting(_position, _velocity):
	position = _position
	velocity = _velocity
	
func _ready():
	look_at(position)
	
func _physics_process(delta):
	velocity = velocity.normalized() * speed
	var collision = move_and_collide(velocity*delta)
	
	if collision:
		# 부딪힌게 플레이어면 플레이어 생명 하나 깎기 or 제거
		if collision.collider.get_collision_layer_bit(0):
			emit_signal("hit_player")
			# if collide with wall, the monster will be destroyed
		if collision.collider.get_collision_layer_bit(1):
			print("monster is dead")
			queue_free()

