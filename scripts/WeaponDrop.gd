extends Sprite

var rng := RandomNumberGenerator.new()
export var weapon_name : String = "pistol"
export var mag_ammo : int = 12
onready var player := get_node("../../Player")
onready var player_inv := get_node("../../Player/Inventory")
onready var prompt := get_node("../../../Interface/Prompt")
onready var prompt_key := get_node("../../../Interface/Prompt/Key")
onready var prompt_text := get_node("../../../Interface/Prompt/Text")
onready var tooltip := $Node/Tooltip
onready var rarity_color : Color = Globals.rarity_colors[player_inv.weapon_data[weapon_name].rarity]

func _ready() -> void:
	# Setup tooltip text, rarity colors, etc.
	tooltip.set_text(weapon_name)
	rarity_color = Globals.rarity_colors[player_inv.weapon_data[weapon_name].rarity]
	material.set_shader_param("color", rarity_color)
	tooltip.add_color_override("font_color", rarity_color)
	rotation = rng.randi_range(75, 90)

func pick_up() -> void:
	if not Input.is_action_just_pressed("pick_up"):
		return
	# Replace current slot if it's empty
	if player_inv.weapons[player_inv.slot] == null:
		pass
	else:
		# Find an empty slot at inventory
		pass

func _physics_process(delta: float) -> void:
	# Update tooltip position
	tooltip.rect_global_position = Vector2(global_position.x-15, global_position.y-17)
	var distance : float = global_position.distance_to(player.global_position)
	var smoothness : float = 250 * delta
	# Scale sprite based on distance
	if distance <= 30:
		prompt.show()
		prompt_key.set_text("E")
		prompt_text.set_text("PICK UP")
		tooltip.show()
		scale.x += (1.3 - scale.x) / smoothness
		scale.y += (1.3 - scale.y) / smoothness
	else:
		prompt.hide()
		tooltip.hide()
		scale.x += (1 - scale.x) / smoothness
		scale.y += (1 - scale.y) / smoothness
	pick_up()
