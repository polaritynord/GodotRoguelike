extends Sprite

onready var inventory := get_node("../Inventory")
var recoil_offset : float = 0

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
	position.y = 5
	# Recoil offsetting
	position.x += cos(rotation) * recoil_offset
	position.y += sin(rotation) * recoil_offset
	var smoothness : float = 300 * delta
	recoil_offset += (-recoil_offset / smoothness)
