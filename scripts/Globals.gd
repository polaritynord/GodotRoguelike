extends Node

var rarity_colors : Dictionary = {
	Enum.rarity.COMMON: Color.white,
	Enum.rarity.RARE: Color.green,
	Enum.rarity.EPIC: Color.purple,
	Enum.rarity.LEGENDARY: Color.orange,
	Enum.rarity.MYTHICAL: Color.orangered
}
var game_paused : bool = false
