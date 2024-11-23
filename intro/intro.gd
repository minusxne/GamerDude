extends Node2D

var main_menu: PackedScene = load("res://main_menu.tscn")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_packed(main_menu)
