# code owner : Minho Jeong
# code sub owner : Hyoyeon Yu

extends Control

var Main
var Option
var story = []
var storyIndex = 0
var volumeSize
var maxV = 5
var minV = -50

func _ready():
	Main = $"Main"
	Option = $"Option"
	story.append($GameStory_1)
	story.append($GameStory_2)
	story.append($GameStory_3)
	story.append($GameStory_4)

# Start game story
func _on_Start_pressed():
	Main.hide()
	story[storyIndex].show()

func _on_Back_pressed():
	Option.hide()
	Main.show()

# Go to next page of game story
func _on_Next_pressed():
	story[storyIndex].hide()
	storyIndex += 1
	story[storyIndex].show()

# Show option menu
func _on_Option_pressed():
	Option.show()
	Main.hide()
	volumeSize = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	volumeSize = (volumeSize - minV)/(maxV-minV) * 100
	Option.get_node("VolumeSize").value =  volumeSize
	
# Change volume
func _on_HSlider_value_changed(value):
	volumeSize = value/100*(maxV-minV) + minV
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), volumeSize)
	if value == 0:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -100)

