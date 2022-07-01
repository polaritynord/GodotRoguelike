extends KinematicBody2D

# Nodes
onready var sprite := $Sprite
onready var inventory := $Inventory
# Variables
export var speed : int = 125
export var sprint_multiplier : float = 1.35
var facing : String = "right"
var velocity : Vector2
var stamina : float = 100.0

func set_facing() -> void:
	var mouse_pos : Vector2 = get_global_mouse_position()
	if mouse_pos.x > global_position.x:
		facing = "right"
	else:
		facing = "left"

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
	# Move by velocity
	velocity = velocity.normalized() * speed * delta
	var _coll := move_and_collide(velocity)

func _physics_process(delta: float) -> void:
	movement(delta)
	set_facing()
