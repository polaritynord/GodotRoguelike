extends Control

onready var bar := $Bar
onready var player_inv := get_node("../../YSort/Player/Inventory")

func _process(_delta: float) -> void:
    # Hide/Show
    if player_inv.reloading_weapon:
        var weapon = player_inv.weapons[player_inv.slot]
        var new_val : float = (Globals.timer - player_inv.reload_timer) / weapon.reload_time * 100
        bar.value = new_val
        show()
    else:
        hide()
