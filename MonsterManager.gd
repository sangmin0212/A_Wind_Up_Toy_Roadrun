extends Node2D

var monsters = preload("res://Monster/Monster.tscn")
var monsterTimer = Timer.new()
var playerPos
var playerVelocity

onready var gameManager = load("res://GameManager.tscn")

func _ready():
	add_child(monsterTimer)
	monsterTimer.connect("timeout",self,"_on_timeout")

func _on_timeout():
	initMonster()

func initMonster():
	var monster = monsters.instance()
	monster.setting(playerPos,playerVelocity)
	add_child(monster)

func _on_GameManager_spawn_monster(_playerPos, _playerVelocity):
	playerPos = _playerPos
	playerVelocity = _playerVelocity
	monsterTimer.set_wait_time(5)
	monsterTimer.start()
