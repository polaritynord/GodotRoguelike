extends Node

func _process(_delta: float) -> void:
	if not Input.is_action_just_pressed("fullscreen"):
		return
	OS.window_fullscreen = !OS.window_fullscreen
