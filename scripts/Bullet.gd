extends Area2D

var speed : int = 750
var damage : float = 5
var lifetime : float =  1.5
var trail_color : Color = Color.white
var lifetime_timer : float = Globals.timer

func _ready() -> void:
	$Trail2D.default_color = trail_color

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta
	# Despawn
	if Globals.timer - lifetime_timer > lifetime:
		queue_free()
