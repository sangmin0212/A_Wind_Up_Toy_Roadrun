extends Node2D


var lastStage = 0


func _ready():
	if $Start != null:
		$Start.connect("timeout", self, "_on_Timer_timeout")
	if $Next != null:
		$Next.connect("timeout", self, "_on_Timer_timeout")
	if $SelectStage != null:
		$SelectStage.connect("timeout", self, "_on_Timer_timeout")
	if $Start != null:
		$Start.connect("timeout", self, "_on_Timer_timeout")

func _exit():
	get_tree().quit()
	
func _load_scene(sceneName, _lastStage):
	get_tree().change_scene("res://Stage/"+sceneName+".tscn")
	lastStage = _lastStage
