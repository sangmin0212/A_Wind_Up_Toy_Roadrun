extends KinematicBody2D

class_name Monster

var monsterManager
var isMonster = false
var hitPlayer = false
var target
var velocity = Vector2.ZERO
var speed = 300

var gameOver = false
var isDead = false

	
func setting(_position, _velocity):
	position = _position
	velocity = _velocity
	
func _ready():
	look_at(position)
	monsterManager = find_parent("MonsterManager")
	
func _physics_process(delta):
	velocity = velocity.normalized() * speed
	var collision = move_and_collide(velocity*delta)
	
	if collision:
		# if collide with player, kill the player!
		if collision.collider.get_collision_layer_bit(0):
			speed = 0
			monsterManager.killPlayer = true
		# if collide with wall, the monster will be destroyed
		if collision.collider.get_collision_layer_bit(1):
			print("monster is dead")
			monsterManager.monsterDead = true
			# GameManager.MonsterTImer start
			queue_free()

