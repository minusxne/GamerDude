extends Node2D

var level = 2

func _process(float) -> void:
	if (GameData.inventory != null && GameData.player != null && GameData.checkinvstate==true):
		GameData.restore_weapon_state()
		GameData.checkinvstate = false

func get_level():
	return level

func _on_player_health_depleted() -> void:
	pass
