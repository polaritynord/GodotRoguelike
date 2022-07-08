extends TextureRect

onready var s_texture := preload("res://textures/weapon_slot.png")
onready var outline_shader := preload("res://resources/outline_material.tres")
onready var slot_weapon := $SlotWeapon
onready var player_inv := get_node("../../../YSort/Player/Inventory")
var slot : int

func _process(_delta: float) -> void:
	# Enable & disable outline
	if slot == player_inv.slot:
		set_material(outline_shader)
	else:
		set_material(null)
	# Set item texture
	if player_inv.weapons[slot] == null:
		slot_weapon.set_texture(null)
	else:
		slot_weapon.set_texture(player_inv.weapons[slot].texture)
		# Set item to fit in the box
		slot_weapon.scale = Vector2(1, 1)
		while slot_weapon.texture.get_width() * slot_weapon.scale.x > 16:
			slot_weapon.scale.x -= 0.05
			slot_weapon.scale.y -= 0.05
