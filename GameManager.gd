extends Node

class_name GameManager

onready var playerManager = get_node("Player")
onready var monsterManager = get_node("MonsterManager")
onready var sceneController = get_parent().get_node("SceneController")

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
	monsterTimer = create_timer("spawn_monster", 1.5)

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
	var GameOver = $"../UI/GameOver"
	GameOver.visible = true
	
func stage_clear():	
	playerManager.stage_clear()
	monsterTimer.stop()
	var StageClear = $"../UI/GameClear"
	StageClear.visible = true
	sceneController._clear_stage(get_parent().name)
	if sceneController.is_stage_clear():
		var Credit = $"../UI/GameClear/Credit"
		Credit.visible = true

	
func start_monster_timer():
	# spawn monster
	print("startMonsterTimer")
	monsterTimer.start()
	playerPos = playerManager.position
	playerVelocity = playerManager.velocity

func spawn_monster():
	monsterTimer.stop()
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


func _on_EndPoint_body_entered(body):
	stage_clear()

func _on_Bomb_body_entered(body):
	game_over()

func _input(event):
	if Input.is_action_pressed("ui_up"):
		stage_clear()
	if Input.is_action_pressed("ui_down"):
		game_over()
			
