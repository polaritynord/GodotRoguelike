extends Control

onready var player_inv := get_node("../../YSort/Player/Inventory")

func _process(_delta: float) -> void:
	var weapon = player_inv.weapons[player_inv.slot]
	if weapon == null:
		hide()
	else:
		show()
		$Name.set_text(weapon.name.capitalize())
		$MagAmmo.set_text(str(weapon.mag_ammo))
		var ammunition : int = player_inv.ammunition[weapon.ammo_type]
		$Ammunition.set_text(str(ammunition))
