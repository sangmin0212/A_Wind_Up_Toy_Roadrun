# code owner : Sangmin Oh

extends Node

class_name GameManager

# Other object
onready var playerManager = get_node("Player")
onready var monsterManager = get_node("MonsterManager")
onready var sceneController = get_parent().get_node("SceneController")

# Game State
var gameStart = false
var gameOver = false
var isMonster = false
var isMonsterSpawn = false

# Player state
var playerPos = Vector2.ZERO
var playerVelocity = Vector2.ZERO

# Timer
var startTimer
var monsterTimer

# Signal
signal spawn_monster(playerPos,playerVelocity)		

func _ready():
	# set time
	# after 3 second, game start
	startTimer = create_timer("game_start", 3)
	monsterTimer = create_timer("spawn_monster", 1.5)
	startTimer.start()

func game_start():
	if !gameStart:
		gameStart = true
		playerManager.game_start()
		# to spawn monster, start monster timer
		start_monster_timer()

# if game_over, call PlayerManager and MonsterManager		
func game_over():
	playerManager.game_over()
	monsterTimer.stop()
	monsterManager.stop_monster()
	var GameOver = $"../UI/GameOver"
	GameOver.visible = true
	
# call if player arrives at endPoint
func stage_clear():	
	playerManager.stage_clear()
	monsterTimer.stop()
	monsterManager.stop_monster()
	sceneController._clear_stage(get_parent().name)
	# if all the stages are over, call credit 
	if sceneController.is_stage_clear():
		var AllStageClear = $"../UI/AllStageClear"
		AllStageClear.visible = true
		yield(get_tree().create_timer(5),"timeout")
		get_tree().change_scene("res://Stage/Credit.tscn")
	else:
		var StageClear = $"../UI/GameClear"
		StageClear.visible = true
		
# spawn monster		
func start_monster_timer():
	print("startMonsterTimer")
	monsterTimer.start()
	playerPos = playerManager.position
	playerVelocity = playerManager.velocity

func spawn_monster():
	monsterTimer.stop()
	isMonsterSpawn = true
	emit_signal("spawn_monster", playerPos, playerVelocity)

# make timer 
# https://godotengine.org/qa/46078/perhaps-a-second-timer
func create_timer (item_func, item_time) -> Timer:
	var timer = Timer.new()    
	add_child(timer)
	timer.set_wait_time (item_time)
	timer.connect("timeout", self, item_func) 
	return timer

# if player collide with EndPoint, call stage_clear()
func _on_EndPoint_body_entered(body):
	stage_clear()

# if player collide with Bomg, call game_over()
func _on_Bomb_body_entered(body):
	game_over()

# cheat key
func _input(event):
	if Input.is_action_pressed("ui_up"):
		stage_clear()
	if Input.is_action_pressed("ui_down"):
		game_over()
			
