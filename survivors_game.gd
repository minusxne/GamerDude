extends Node2D

func _on_player_health_depleted() -> void:
	%GameOver.visible=true
	get_tree().paused=true
