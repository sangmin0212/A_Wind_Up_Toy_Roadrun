# code owner : Sangmin Oh

extends Node2D

onready var gameManager = find_parent("GameManager")
onready var monsters = preload("res://Monster/Monster.tscn")

# Players information
var playerPos
var playerVelocity
var monster

# Monster state
var monsterIs = false
var monsterDead = false
var killPlayer = false

# if GameManager.monsterTimer time is over, spawn monster
func _on_GameManager_spawn_monster(_playerPos, _playerVelocity):
	monster = monsters.instance()
	monster.setting(_playerPos,_playerVelocity)
	add_child(monster)
	monsterIs = true

# stop monster if player is died
func stop_monster():
	if monster != null and monsterIs:
		monster.stop()

# if monster kill the player, stop monsterTimer and call gameManager.game_over().
func kill_player():
	gameManager.monsterTimer.stop()
	gameManager.game_over()

# if monster dead, call gamaManager and re-start monsterTimer
func monster_dead():
	gameManager.start_monster_timer()
	monsterIs = false
