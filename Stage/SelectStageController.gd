extends Node2D

onready var sceneController = get_parent().get_node("SceneController")

func _ready():
	var stageClear = sceneController.stageClear
	for stage in stageClear:
		if stageClear[stage] == false:
			var button
			
			if str(stage) == "Stage2":
				button = get_parent().get_node("Stages/Stage2")
				var lock = button.get_node("Lock")
				lock.visible = true
			elif str(stage) == "Stage3":
				button = get_parent().get_node("Stages/Stage3")
				var lock = button.get_node("Lock")
				lock.visible = true
			elif str(stage) == "Stage4":
				button = get_parent().get_node("Stages/Stage4")
				var lock = button.get_node("Lock")
				lock.visible = true
			elif str(stage) == "Stage5":
				button = get_parent().get_node("Stages/Stage5")
				var lock = button.get_node("Lock")
				lock.visible = true
			elif str(stage) == "Stage6":
				button = get_parent().get_node("Stages/Stage6")
				var lock = button.get_node("Lock")
				lock.visible = true
			button.disabled = true
		
