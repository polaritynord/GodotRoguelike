extends KinematicBody2D

# Nodes
onready var sprite := $Sprite
onready var inventory := $Inventory
# Variables
export var speed : int = 125
export var sprint_multiplier : float = 0.485
var facing : String = "right"
var velocity : Vector2
var stamina : float = 100.0
var sprint_cooldown : float = 2.5
var sprinting : bool = false
var moving : bool = false
# Timers
var sprint_timer : float = -sprint_cooldown

func set_facing() -> void:
	var mouse_pos : Vector2 = get_global_mouse_position()
	if mouse_pos.x > global_position.x:
		facing = "right"
	else:
		facing = "left"

func sprint(delta: float) -> void:
	if !Input.is_action_pressed("sprint") or Globals.timer - sprint_timer < sprint_cooldown or not moving:
		sprinting = false
		# Increase stamina
		stamina += 35 * delta
		if stamina > 100:
			stamina = 100
		return
	sprinting = true
	if abs(velocity.x) > 0:
		velocity.x += (abs(velocity.x) / velocity.x) * sprint_multiplier
	if abs(velocity.y) > 0:
		velocity.y += (abs(velocity.y) / velocity.y) * sprint_multiplier
	stamina -= 30 * delta
	if stamina < 0:
		sprint_timer = Globals.timer

func movement(delta: float) -> void:
	# Get key input
	velocity = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	moving = abs(velocity.x) > 0 or abs(velocity.y) > 0
	sprint(delta)
	# Normalize velocity
	if abs(velocity.x) == abs(velocity.y):
		velocity.x /= 1.25
		velocity.y /= 1.25
	# Move by velocity
	velocity = velocity * speed * delta
	var _coll := move_and_collide(velocity)

func _physics_process(delta: float) -> void:
	movement(delta)
	set_facing()
