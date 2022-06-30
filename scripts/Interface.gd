extends CanvasLayer

onready var debug_menu := $DebugMenu

func toggle_debug() -> void:
	if !Input.is_action_just_pressed("debug"):
		return
	if debug_menu.is_visible():
		debug_menu.hide()
	else:
		debug_menu.show()

func _process(_delta: float) -> void:
	toggle_debug()
