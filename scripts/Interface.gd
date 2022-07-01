extends CanvasLayer

onready var debug_menu := $DebugMenu
onready var stamina_bar := $StaminaBar
onready var player = get_node("../YSort/Player")
onready var stamina_alpha : float = 1

func toggle_debug() -> void:
	if !Input.is_action_just_pressed("debug"):
		return
	if debug_menu.is_visible():
		debug_menu.hide()
	else:
		debug_menu.show()

func update_stamina_bar(delta: float) -> void:
	stamina_bar.value = player.stamina
	stamina_bar.modulate.a = stamina_alpha

func _process(delta: float) -> void:
	toggle_debug()
	update_stamina_bar(delta)
