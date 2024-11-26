extends Node2D

var level = 25

func _ready() -> void:
	GameData.checkinvstate = true
	$transition/ColorRect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	%Health.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$CanvasLayer/white.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$CanvasLayer/black.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$staticCanvasLayer/ColorRect.mouse_filter = Control.MOUSE_FILTER_IGNORE


func _process(float) -> void:
	if (GameData.inventory != null && GameData.player != null && GameData.checkinvstate==true):
		GameData.restore_weapon_state()
		GameData.checkinvstate = false

func get_level():
	return level

func _on_player_health_depleted() -> void:
	pass
