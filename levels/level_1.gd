extends Node2D

var level = 1

func _ready() -> void:
	$transition/ColorRect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	%Health.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$CanvasLayer/white.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$CanvasLayer/black.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$staticCanvasLayer/ColorRect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$staticCanvasLayer/MenuButton.mouse_filter = Control.MOUSE_FILTER_PASS

func get_level():
	return level

func _on_player_health_depleted() -> void:
	pass
