extends Resource

# Core variables
var name : String = "assault rifle"
var type : int = Enum.weapon.AUTO
var ammo_type : int = Enum.ammo.MEDIUM
var rarity : int = Enum.rarity.COMMON
# Bullet based attributes
var bullet_per_shot : int = 1
var bullet_spread : float = 0.065
var bullet_damage : int = 16
var bullet_speed : int = 1500
var bullet_lifetime : float = 3.5
var shoot_cooldown : float = 0.06
# Magazine variables
var mag_ammo : int = 0
var mag_size : int = 30
var reload_time : float = 2.1
# Visuals
var texture : Texture = preload("res://textures/auto_rifle.png")
var recoil_rate : float = 5
