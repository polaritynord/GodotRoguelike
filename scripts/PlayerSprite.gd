extends Sprite

func _process(delta: float) -> void:
	var smoothness : float = 0.05 / delta
	if owner.facing == "right":
		scale.x += (1 - scale.x) / smoothness
	else:
		scale.x += (-1 - scale.x) / smoothness
