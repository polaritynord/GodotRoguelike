extends Node

var rng := RandomNumberGenerator.new()

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
	Enum.ammo.LIGHT: 12,
	Enum.ammo.MEDIUM: 0,
	Enum.ammo.REVOLVER: 0,
	Enum.ammo.ROCKET: 0
}
var slot : int = 0
var prev_slot : int = 0
var shoot_timer : float = 0.0
var reload_timer : float = 0.0
var reloading_weapon : bool = false

func setup_arrays() -> void:
	for _i in range(max_weapon_slot):
		weapons.append(null)
	for _i in range(max_item_slot):
		items.append(null)

func switch_slot() -> void:
	if reloading_weapon:
		return
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
	var dropped_weapon = weapon_drop.instance()
	# Drop weapon
	dropped_weapon.global_position = owner.global_position
	dropped_weapon.weapon = weapons[slot]
	dropped_weapon.mag_ammo = weapons[slot].mag_ammo
	dropped_weapon.drop_velocity = 600
	dropped_weapon.drop_angle = held_item.global_rotation
	drop_container.add_child(dropped_weapon)
	# Clear current slot
	weapons[slot] = null

func shoot_bullet(weapon: Resource) -> void:
	shoot_timer = Globals.timer
	for _i in range(weapon.bullet_per_shot):
		if weapon.mag_ammo < 1:
			continue
		# Create recoil effect on held item
		held_item.recoil_offset = weapon.recoil_rate
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
		# Set lifetime
		new_bullet.lifetime = weapon.bullet_lifetime
		# Add bullet instance to tree
		bullet_container.add_child(new_bullet)
	
		weapon.mag_ammo -= 1

func shoot() -> void:
	if weapons[slot] == null or reloading_weapon:
		return
	var weapon = weapons[slot]
	if Globals.timer - shoot_timer < weapon.shoot_cooldown:
		return
	# Shoot current weapon
	match weapon.type:
		Enum.weapon.MANUAL:
			if Input.is_action_just_pressed("shoot"):
				shoot_bullet(weapon)
		Enum.weapon.AUTO:
			if Input.is_action_pressed("shoot"):
				shoot_bullet(weapon)

func reload_input() -> void:
	if !Input.is_action_just_pressed("reload"):
		return
	# Check if player is holding a weapon & mag isn't full, or already reloading
	var weapon : Resource = weapons[slot]
	if weapon == null or weapon.mag_ammo == weapon.mag_size or reloading_weapon:
		return
	# Return if there is no ammunition remaining
	if ammunition[weapon.ammo_type] < 1:
		return
	reloading_weapon = true
	reload_timer = Globals.timer

func reload_weapon() -> void:
	if !reloading_weapon:
		return
	var weapon : Resource = weapons[slot]
	var ammo : int = ammunition[weapon.ammo_type]
	if Globals.timer - reload_timer > weapon.reload_time:
		reloading_weapon = false
		# Reload weapon
		var diff : int = weapon.mag_size - weapon.mag_ammo
		if diff > ammo:
			weapon.mag_ammo = weapon.mag_ammo + ammo
			ammunition[weapon.ammo_type] = 0
		else:
			weapon.mag_ammo += diff
			ammunition[weapon.ammo_type] -= diff

func _ready() -> void:
	setup_arrays()

func _process(_delta: float) -> void:
	switch_slot()
	held_item_update()
	drop_weapon()
	shoot()
	# Reloading stuff
	reload_input()
	reload_weapon()
