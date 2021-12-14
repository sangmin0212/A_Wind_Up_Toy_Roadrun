extends Control

var Main
var Option
var volumeSize
var maxV = 5
var minV = -50

func _ready():
	Main = $"Main"
	Option = $"Option"

func _goto_next_level():
	get_tree().change_scene("res://Stage/Stage1.tscn")

func _on_Start_pressed():
	_goto_next_level();

func _on_Exit_pressed():
	get_tree().quit()


func _on_Back_pressed():
	Option.hide()
	Main.show()


func _on_Option_pressed():
	Option.show()
	Main.hide()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -10)
	volumeSize = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	volumeSize = (volumeSize - minV)/(maxV-minV) * 100
	Option.get_node("VolumeSize").value =  volumeSize
	

func _on_HSlider_value_changed(value):
	volumeSize = value/100*(maxV-minV) + minV
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), volumeSize)
	if value == 0:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -100)
