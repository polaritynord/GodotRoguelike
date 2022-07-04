extends Sprite

onready var inventory := get_node("../Inventory")

func _process(delta: float) -> void:
	# Set rotation
	if inventory.reloading_weapon:
		rotation += 18 * delta
	else:
		look_at(get_global_mouse_position())
	# Set position
	if owner.facing == "right":
		scale.x = 1.25
		position.x = 10
	else:
		scale.x = -1.25
		if !inventory.reloading_weapon:
			rotation -= 135
		position.x = -10
