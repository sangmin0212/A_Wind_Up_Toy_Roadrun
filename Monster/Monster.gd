extends KinematicBody2D

class_name Monster

var monsterManager
var isMonster = false
var hitPlayer = false
var target
var velocity = Vector2.ZERO
var speed = 100

var gameOver = false
var isDead = false

onready var _animation_player = $AnimationPlayer
var state = "Idle"
	
func setting(_position, _velocity):
	position = _position
	velocity = _velocity
	
func _ready():
	look_at(position)
	monsterManager = find_parent("MonsterManager")
	
func _physics_process(delta):
	update_sprite()
	velocity = velocity.normalized() * speed
	var collision = move_and_collide(velocity*delta)
	
	if collision and !gameOver:
		# if collide with player, kill the player!
		if collision.collider.get_collision_layer_bit(0):
			speed = 0
			monsterManager.kill_player()
			get_node("CollisionPolygon2D").disabled = true
			yield(get_tree().create_timer(1.5),"timeout")
			gameOver = true
		# if collide with wall, the monster will be destroyed
		if collision.collider.get_collision_layer_bit(1):
			print("monster is dead")
			monsterManager.monster_dead()
			speed = 0
			state = "Die"
			yield(get_tree().create_timer(1),"timeout")
			queue_free()

func update_sprite():
	if _animation_player.get_current_animation() != state:
		_animation_player.play(state);
	if state == "Die":
		gameOver = true
