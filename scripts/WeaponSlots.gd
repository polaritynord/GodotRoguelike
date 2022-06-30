extends HBoxContainer

onready var weapon_slot := preload("res://scenes/WeaponSlotUI.tscn")
onready var player_inv := get_node("../../YSort/Player/Inventory")

func _ready() -> void:
	# Clear placeholder slots
	for i in get_children():
		remove_child(i)
		i.queue_free()
	# Create slots
	for i in range(player_inv.max_weapon_slot):
		var new_slot : Node = weapon_slot.instance()
		new_slot.slot = i
		add_child(new_slot)
