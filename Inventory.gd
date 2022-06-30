extends Node

class Weapon:
	var name : String
	var type  # I'm not really sure about the types of enums
	var ammo_type
	var bullet_per_shot : int
	var bullet_spread : float
	var bullet_damage : float
	var bullet_speed : int
	var mag_size : int

export var max_weapon_slot : int = 3
export var max_item_slot : int = 20
var weapons : Array
var items : Array
var ammunition : Dictionary = {
	Globals.ammo_types.LIGHT: 96,
	Globals.ammo_types.MEDIUM: 0,
	Globals.ammo_types.REVOLVER: 0,
	Globals.ammo_types.ROCKET: 0
}
var slot : int = 0
var prev_slot : int = 1

func setup_arrays() -> void:
	for i in range(max_weapon_slot):
		weapons.append(null)
	for i in range(max_item_slot):
		weapons.append(null)

func switch_slot() -> void:
	# Switching slots through special keys
	for i in range(max_weapon_slot):
		if Input.is_action_just_pressed("slot" + str(i)) and slot != i:
			prev_slot = slot
			slot = i
	# Swap to previous slot
	if Input.is_action_just_pressed("prev_slot"):
		var new_slot : int = prev_slot
		prev_slot = slot
		slot = new_slot


func _ready() -> void:
	setup_arrays()

func _process(_delta: float) -> void:
	switch_slot()
	print(slot, " ", prev_slot)
