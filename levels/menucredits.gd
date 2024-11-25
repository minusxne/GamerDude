extends CollisionShape2D

@onready var body = $".."
@onready var animationplayer = $"../.."
var clicked = false
@onready var current_scale = body.scale
var lvl1: PackedScene =load("res://main_menu.tscn")

#??

func _process(delta):
	if clicked:
		get_tree().change_scene_to_packed(lvl1)
	var mouse_pos = get_viewport().get_mouse_position()
	if shape is RectangleShape2D:
		var rect = shape
		var shape_position = global_position
		if mouse_pos.x >= shape_position.x - rect.extents.x and \
		   mouse_pos.x <= shape_position.x + rect.extents.x and \
		   mouse_pos.y >= shape_position.y - rect.extents.y and \
		   mouse_pos.y <= shape_position.y + rect.extents.y and \
		   Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			clicked = true
