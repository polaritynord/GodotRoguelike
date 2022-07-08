extends Resource

# Core variables
var name : String = "shotgun"
var type : int = Enum.weapon.MANUAL
var ammo_type : int = Enum.ammo.SHOTGUN
var rarity : int = Enum.rarity.COMMON
# Bullet based attributes
var bullet_per_shot : int = 3
var bullet_spread : float = 0.135
var bullet_damage : int = 15
var bullet_speed : int = 1500
var bullet_lifetime : float = 3.5
var shoot_cooldown : float = 0.45
# Magazine variables
var mag_ammo : int = 0
var mag_size : int = 9
var reload_time : float = 2.4
# Visuals
var texture : Texture = preload("res://textures/shotgun.png")
var recoil_rate : float = 7.2
