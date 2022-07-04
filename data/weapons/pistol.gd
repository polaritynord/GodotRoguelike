extends Resource

# Core variables
var name : String = "pistol"
var type : int = Enum.weapon.AUTO
var ammo_type : int = Enum.ammo.LIGHT
var rarity : int = Enum.rarity.COMMON
# Bullet based attributes
var bullet_per_shot : int = 1
var bullet_spread : float = 0.035
var bullet_damage : int = 10
var bullet_speed : int = 1500
var bullet_lifetime : float = 3.5
var shoot_cooldown : float = 0.265
# Magazine variables
var mag_ammo : int = 0
var mag_size : int = 12
var reload_time : float = 1.5
# Visuals
var texture : Texture = preload("res://textures/pistol.png")
