# code owner : Sangmin Oh

extends KinematicBody2D

class_name Monster

# Transform
var velocity = Vector2.ZERO
var speed = 220

# State
var isMonster = false
var hitPlayer = false
var gameOver = false
var isDead = false

# Other object
var monsterManager
var target

# Animation
onready var _animation_player = $AnimationPlayer
var state = "Idle"

# Sound
onready var monsterAppear = $MonsterAppear
onready var monsterDead = $MonsterDead
onready var killPlayer = $KillPlayer
	
# Get the player's information and set the monster.
func setting(_position, _velocity):
	position = _position
	velocity = _velocity
	
func _ready():
	look_at(position)
	monsterManager = find_parent("MonsterManager")
	
	
func _physics_process(delta):
	# update animation
	update_animation()
	
	# monster will be moved toward player
	velocity = velocity.normalized() * speed
	var collision = move_and_collide(velocity*delta)
	
	if collision and !gameOver:
		# if collide with player, kill the player
		if collision.collider.get_collision_layer_bit(0):
			speed = 0
			monsterManager.kill_player()
			state = "Kill"
			get_node("CollisionShape2D").disabled = true
			killPlayer.play()
			yield(get_tree().create_timer(1),"timeout")
			gameOver = true
		# if collide with wall, the monster will be destroyed
		if collision.collider.get_collision_layer_bit(1):
			print("monster is dead")
			monsterManager.monster_dead()
			speed = 0
			state = "Die"
			monsterDead.play()
			yield(get_tree().create_timer(1),"timeout")
			queue_free()

func update_animation():
	if _animation_player.get_current_animation() != state:
		_animation_player.play(state);
	if state == "Die":
		gameOver = true
		
func stop():
	speed = 0
