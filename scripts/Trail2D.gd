extends Line2D

onready var player_sprite := owner.get_node("Sprite")
onready var original_width : float = width
export var length : int = 50

func _process(_delta: float) -> void:
	width = abs(owner.scale.x * original_width)
	global_position = Vector2.ZERO
	global_rotation = 0
	
	add_point(owner.global_position)
	while get_point_count() > length:
		remove_point(0)
