extends VBoxContainer

onready var player := get_node("../../YSort/Player")

func _process(_delta: float) -> void:
	# FPS
	var fps_text : String = str(Engine.get_frames_per_second()) + "/60 fps"
	$FPS.set_text(fps_text)
	# Coordinates
	var coordinates : String = "x: " + str(int(player.global_position.x)) + "  y: " + str(int(player.global_position.y))
	$Coordinates.set_text(coordinates)
