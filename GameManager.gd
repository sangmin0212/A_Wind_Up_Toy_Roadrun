extends Node

class_name GameManager

onready var monsterManager = preload("res://Monster/Monster.tscn")
onready var playerManager = get_node("Player")

signal spawn_monster(playerPos,playerVelocity)

var gameStart = false
var isMonster = false

var startPoint = Vector2(20,20)
var playerPos = Vector2.ZERO
var playerVelocity = Vector2.ZERO
var startTimer = Timer.new()
var monsterTimer = Timer.new()


func _ready():
	add_child(startTimer)
	startTimer.connect("timeout",self,"_on_timeout")
	startTimer.set_wait_time(3)
	startTimer.start()

	# pause player	

func _process(delta):
	pass

func spawnMonseter():
	playerPos = playerManager.position
	playerVelocity = playerManager.velocity
	emit_signal("spawn_monster", playerPos, playerVelocity)
		
func _on_timeout():
	if !gameStart:
		gameStart = true
		
		# after 3 second, start player	
		playerManager.start()
		
		# deliver player's information to the monster.
		spawnMonseter()

	

	
