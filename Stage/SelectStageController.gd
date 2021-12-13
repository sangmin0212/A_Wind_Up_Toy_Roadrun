extends Node2D

onready var sceneController = get_parent().get_node("SceneController")

func _ready():
	var stageClear = sceneController.stageClear
	for stage in stageClear:
		if stageClear[stage] == false:
			var button = get_parent().get_node("Stages").get_node(str(stage))
			print(button)
