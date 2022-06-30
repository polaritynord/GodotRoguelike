extends Line2D

export var length : int = 50

func _process(delta: float) -> void:
	global_position = Vector2.ZERO
	global_rotation = 0
	
	add_point(owner.global_position)
	while get_point_count() > length:
		remove_point(0)
