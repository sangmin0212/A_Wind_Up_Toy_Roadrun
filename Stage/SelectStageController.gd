extends Node2D

onready var sceneController = get_parent().get_node("SceneController")

func _ready():
	var stageClear = sceneController.stageClear
	for stage in stageClear:
		if stageClear[stage] == false:
			var button
			if str(stage) == "Stage2":
				button = get_parent().get_node("Stages/Stage2")
			elif str(stage) == "Stage3":
				button = get_parent().get_node("Stages/Stage3")
			elif str(stage) == "Stage4":
				button = get_parent().get_node("Stages/Stage4")
			elif str(stage) == "Stage5":
				button = get_parent().get_node("Stages/Stage5")
			elif str(stage) == "Stage6":
				button = get_parent().get_node("Stages/Stage6")
			button.disabled = true
		
