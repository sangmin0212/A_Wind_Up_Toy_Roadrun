extends Node

class_name Stage1

onready var playerManager = get_node("Player")
onready var monsterManager = get_node("MonsterManager")

signal spawn_monster(playerPos,playerVelocity)

var gameStart = false
var gameOver = false
var isMonster = false

var startPoint = Vector2(20,20)
var playerPos = Vector2.ZERO
var playerVelocity = Vector2.ZERO
var startTimer
var monsterTimer
var isSpawnMonster


func _ready():
	# set timer
	startTimer = create_timer("game_start", 3)
	monsterTimer = create_timer("spawn_monster", 3)

	startTimer.start()

func game_start():
	if !gameStart:
		gameStart = true
		# after 3 second, start player	
		playerManager.game_start()
		# to spawn monster, start monster timer
		start_monster_timer()
		
func game_over():
	playerManager.game_over()
	monsterTimer.stop()

	
func start_monster_timer():
	# spawn monster
	monsterTimer.start()
	playerPos = playerManager.position
	playerVelocity = playerManager.velocity

func spawn_monster():
	isSpawnMonster = true
	emit_signal("spawn_monster", playerPos, playerVelocity)


# make timer 
# https://godotengine.org/qa/46078/perhaps-a-second-timer
func create_timer (item_func, item_time) -> Timer:
	var timer = Timer.new()    
	add_child(timer)
	timer.set_wait_time (item_time)
	timer.connect("timeout", self, item_func) 
	return timer


