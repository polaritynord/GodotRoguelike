extends CanvasLayer

onready var debug_menu := $DebugMenu
onready var stamina_bar := $StaminaBar
onready var player = get_node("../YSort/Player")
var stamina_alpha : float = 1
var stamina_timer : float = 0
var old_stamina : float

func toggle_debug() -> void:
	if !Input.is_action_just_pressed("debug"):
		return
	if debug_menu.is_visible():
		debug_menu.hide()
	else:
		debug_menu.show()

func update_stamina_bar(delta: float) -> void:
	if old_stamina != player.stamina:
		stamina_timer = Globals.timer
		stamina_alpha = 1
	old_stamina = player.stamina
	# Update alpha
	if Globals.timer - stamina_timer > 3:
		stamina_alpha -= 3.36 * delta
	# Set values
	stamina_bar.value = player.stamina
	stamina_bar.modulate.a = stamina_alpha

func _process(delta: float) -> void:
	toggle_debug()
	update_stamina_bar(delta)
