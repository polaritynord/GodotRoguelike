extends Sprite

func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	if owner.facing == "right":
		scale.x = 1.25
		position.x = 10
	else:
		scale.x = -1.25
		rotation -= 135
		position.x = -10
