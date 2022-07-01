extends Camera2D

func _process(delta: float) -> void:
	var smoothness : float = 258 * delta
	if owner.sprinting:
		zoom.x += (1.029 - zoom.x) / smoothness
		zoom.y += (1.029 - zoom.y) / smoothness
	else:
		zoom.x += (1.1 - zoom.x) / smoothness
		zoom.y += (1.1 - zoom.y) / smoothness

