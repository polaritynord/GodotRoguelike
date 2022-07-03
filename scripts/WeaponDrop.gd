extends Sprite

var rng := RandomNumberGenerator.new()
var drop_angle : float = 0
var drop_velocity : float = 0
var being_picked_up : bool = false
var rarity_color : Color

export var weapon : Resource
export var mag_ammo : int = 12

onready var player := get_node("../../Player")
onready var player_inv := get_node("../../Player/Inventory")
onready var tooltip := $Node/Tooltip

func _ready() -> void:
	weapon = weapon.new()
	# Set tooltip position
	tooltip.rect_global_position = Vector2(global_position.x-15, global_position.y-17)
	# Setup tooltip text, rarity colors, etc.
	tooltip.set_text(weapon.name)
	rarity_color = Globals.rarity_colors[weapon.rarity]
	material.set_shader_param("color", rarity_color)
	tooltip.add_color_override("font_color", rarity_color)
	rotation = rng.randi_range(75, 90)
	# Set texture
	set_texture(weapon.texture)

func pick_up() -> void:
	if not Input.is_action_just_pressed("pick_up") or not null in player_inv.weapons:
		return
	weapon.mag_ammo = mag_ammo
	# Replace current slot if it's empty
	if player_inv.weapons[player_inv.slot] == null:
		player_inv.weapons[player_inv.slot] = weapon
	else:
		# Find an empty slot at inventory
		var slot : int = 0
		while true:
			if player_inv.weapons[slot] == null:
				break
			slot += 1
		player_inv.weapons[slot] = weapon
	
	# Start picking up animation
	being_picked_up = true

func move_by_velocity(delta: float) -> void:
	# Move by velocity
	global_position.x += cos(drop_angle) * drop_velocity * delta
	global_position.y += sin(drop_angle) * drop_velocity * delta
	# Decrease velocity
	var vel_smoothness : float = 223 * delta
	drop_velocity += -drop_velocity / vel_smoothness

func check_distance(delta: float) -> void:
	var distance : float = global_position.distance_to(player.global_position)
	var smoothness : float = 250 * delta
	# Scale sprite based on distance
	if distance <= 30 and !being_picked_up:
		pick_up()
		tooltip.show()
		scale.x += (1.3 - scale.x) / smoothness
		scale.y += (1.3 - scale.y) / smoothness
	else:
		tooltip.hide()
		scale.x += (1 - scale.x) / smoothness
		scale.y += (1 - scale.y) / smoothness

func pick_up_anim(delta: float) -> void:
	if !being_picked_up:
		return
	# Move towards player
	var temp : float = global_rotation
	var d : float = global_position.distance_to(player.global_position)
	var vel : float = (d / 30) * 385
	look_at(player.global_position)
	global_position.x += cos(global_rotation) * vel * delta
	global_position.y += sin(global_rotation) * vel * delta
	modulate.a = d / 30
	global_rotation = temp
	# Despawn when distance < 1
	if d < 1:
		queue_free()

func _physics_process(delta: float) -> void:
	# Update tooltip position
	tooltip.rect_global_position = Vector2(global_position.x-15, global_position.y-17)
	check_distance(delta)
	move_by_velocity(delta)
	pick_up_anim(delta)
