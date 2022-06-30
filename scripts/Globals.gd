extends Node

var rarity_colors : Dictionary = {
	Enum.RARITY_COMMON: Color.white,
	Enum.RARITY_RARE: Color.green,
	Enum.RARITY_EPIC: Color.purple,
	Enum.RARITY_LEGENDARY: Color.orange,
	Enum.RARITY_MYTHICAL: Color.orangered
}
var game_paused : bool = false
