extends Node

var rng := RandomNumberGenerator.new()
var weapon_dic : Dictionary = {
	"name": "",
	"type": Enum.weapon.MANUAL,
	"ammo_type": Enum.ammo.LIGHT,
	"bullet_per_shot": 1,
	"bullet_spread": 0,
	"bullet_damage": 8,
	"bullet_speed": 2000,
	"mag_size": 12,
	"mag_ammo": 0,
	"texture": null,
	"rarity": Enum.rarity.COMMON,
	"shoot_cooldown": 0,
	"despawn_time": 3.5,
	"reload_time": 1.5
}

onready var pistol_texture := preload("res://textures/pistol.png")
onready var held_item := owner.get_node("HeldItem")
onready var drop_container := get_node("../../DropContainer")
onready var bullet_container := get_node("../../../BulletContainer")
onready var shoot_position := held_item.get_node("ShootPosition")
onready var bullet := preload("res://scenes/Bullet.tscn")

export var max_weapon_slot : int = 6
export var max_item_slot : int = 20

var weapon_drop := preload("res://scenes/WeaponDrop.tscn")
var weapons : Array
var items : Array
var weapon_data : Dictionary = {}
var item_data : Array
var ammunition : Dictionary = {
	Enum.ammo.LIGHT: 96,
	Enum.ammo.MEDIUM: 0,
	Enum.ammo.REVOLVER: 0,
	Enum.ammo.ROCKET: 0
}
var slot : int = 0
var prev_slot : int = 0
var shoot_timer : float = 0.0

func new_weapon(
	name: String, type, ammo_type, bullet_per_shot: int, bullet_spread: float, bullet_damage: float,
	bullet_speed: int, mag_size: int, texture: Texture, rarity, shoot_cooldown: float, despawn_time: float,
	reload_time: float
) -> void:
	var weapon = weapon_dic.duplicate()
	weapon.name = name
	weapon.type = type
	weapon.ammo_type = ammo_type
	weapon.bullet_per_shot = bullet_per_shot
	weapon.bullet_spread = bullet_spread
	weapon.bullet_damage = bullet_damage
	weapon.bullet_speed = bullet_speed
	weapon.mag_size = mag_size
	weapon.texture = texture
	weapon.mag_ammo = mag_size
	weapon.rarity = rarity
	weapon.shoot_cooldown = shoot_cooldown
	weapon.despawn_time = despawn_time
	weapon.reload_time = reload_time
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

func drop_weapon() -> void:
	if !Input.is_action_just_pressed("drop_weapon") or weapons[slot] == null:
		return
	# Drop weapon
	var dropped_weapon = weapon_drop.instance()
	dropped_weapon.global_position = owner.global_position
	dropped_weapon.name = weapons[slot].name
	dropped_weapon.mag_ammo = weapons[slot].mag_ammo
	dropped_weapon.drop_velocity = 600
	dropped_weapon.drop_angle = held_item.global_rotation
	drop_container.add_child(dropped_weapon)
	# Clear current slot
	weapons[slot] = null

func _ready() -> void:
	setup_arrays()
	new_weapon(
		"pistol", Enum.weapon.MANUAL, Enum.ammo.LIGHT, 1, 0.035, 10, 2500, 12,
		pistol_texture, Enum.rarity.EPIC, 0, 3.5, 1.4
	)

func shoot() -> void:
	if weapons[slot] == null:
		return
	var weapon = weapons[slot]
	if weapon.type == Enum.weapon.MANUAL and Input.is_action_just_pressed("shoot"):
		for _i in range(weapon.bullet_per_shot):
			if weapon.mag_ammo < 1:
				continue
			var new_bullet = bullet.instance()
			# Set speed
			new_bullet.speed = weapon.bullet_speed
			# Set position
			new_bullet.global_position = shoot_position.global_position
			# Set rotation
			new_bullet.rotation = shoot_position.global_rotation
			new_bullet.rotation += rng.randf_range(-weapon.bullet_spread, weapon.bullet_spread)
			# Set damage
			new_bullet.damage = weapon.bullet_damage
			# Set trail color
			new_bullet.trail_color = Globals.rarity_colors[weapon.rarity]
			# Add bullet instance to tree
			bullet_container.add_child(new_bullet)
			weapon.mag_ammo -= 1

func _process(_delta: float) -> void:
	switch_slot()
	held_item_update()
	drop_weapon()
	shoot()
