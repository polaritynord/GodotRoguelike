extends Sprite

func _ready() -> void:
	# Hide real cursor
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	show()

func _process(_delta: float) -> void:
	var mouse_pos : Vector2 = get_global_mouse_position()
	position = mouse_pos
