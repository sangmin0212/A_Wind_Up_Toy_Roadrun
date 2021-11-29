extends Node2D

onready var gameManager = find_parent("GameManager")
onready var monsters = preload("res://Monster/Monster.tscn")

var playerPos
var playerVelocity
var monster

var monsterDead = false
var killPlayer = false

func _on_GameManager_spawn_monster(_playerPos, _playerVelocity):
	monster = monsters.instance()
	monster.setting(_playerPos,_playerVelocity)
	add_child(monster)

func _process(delta):
	if killPlayer == true:
		# 게임 매니저 가서 게임 중지
		gameManager.is_gameOver()
	if monsterDead == true:
		# 두번째 생성부터 텀 빠르게 하고 싶으면 gameManager.MonsterTimer.set_wait_time(몇초) 하기
		gameManager.start_monster_timer()
		monsterDead = false
	
