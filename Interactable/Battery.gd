extends Area2D

class_name Battery
onready var batterySound = $BatterySound

# 플레이어가 배터리와 닿으면
func _on_Battery_body_entered(body):
	# body not Monster
	if body is PlayerManager:
		batterySound.play()
	# reomve the object from the memory
		queue_free()
