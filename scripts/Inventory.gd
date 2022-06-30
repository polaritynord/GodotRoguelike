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
	var texture : Texture

onready var usp_texture := preload("res://textures/pistol.png")
onready var held_item := owner.get_node("HeldItem")
export var max_weapon_slot : int = 6
export var max_item_slot : int = 20
var weapons : Array
var items : Array
var weapon_data : Dictionary = {}
var item_data : Array
var ammunition : Dictionary = {
	Globals.ammo_types.LIGHT: 96,
	Globals.ammo_types.MEDIUM: 0,
	Globals.ammo_types.REVOLVER: 0,
	Globals.ammo_types.ROCKET: 0
}
var slot : int = 0
var prev_slot : int = 1

func new_weapon(
	name: String, type, ammo_type, bullet_per_shot: int, bullet_spread: float, bullet_damage: float,
	bullet_speed: int, mag_size: int, texture: Texture
) -> void:
	var weapon : Weapon = Weapon.new()
	weapon.name = name
	weapon.type = type
	weapon.ammo_type = ammo_type
	weapon.bullet_per_shot = bullet_per_shot
	weapon.bullet_spread = bullet_spread
	weapon.bullet_damage = bullet_damage
	weapon.bullet_speed = bullet_speed
	weapon.mag_size = mag_size
	weapon.texture = texture
	weapon_data[name] = weapon

func setup_arrays() -> void:
	for _i in range(max_weapon_slot):
		weapons.append(null)
	for _i in range(max_item_slot):
		items.append(null)

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

func held_item_update() -> void:
	if weapons[slot] == null:
		held_item.set_texture(null)
	else:
		held_item.set_texture(weapons[slot].texture)

func _ready() -> void:
	setup_arrays()
	new_weapon(
		"pistol", Globals.weapon_types.MANUAL, Globals.ammo_types.LIGHT, 1,0, 10, 2500, 12,
		usp_texture
	)
	weapons[0] = weapon_data["pistol"]

func _process(_delta: float) -> void:
	switch_slot()
	held_item_update()
