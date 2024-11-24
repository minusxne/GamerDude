extends CollisionShape2D

@onready var body = $".."
@onready var animationplayer = $"../.."
var clicked = false
var clickforce = false
@onready var current_scale = body.scale

#??

func _process(delta):
	if clicked:
		return

	var mouse_pos = get_viewport().get_mouse_position()
	if shape is RectangleShape2D:
		var rect = shape
		var shape_position = global_position
		if mouse_pos.x >= shape_position.x - rect.extents.x and \
		   mouse_pos.x <= shape_position.x + rect.extents.x and \
		   mouse_pos.y >= shape_position.y - rect.extents.y and \
		   mouse_pos.y <= shape_position.y + rect.extents.y and \
		   Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) || clickforce:

			# Store the current transform
			var current_position = body.global_position
			var current_rotation = body.global_rotation

			# Stop animation
			animationplayer.stop()

			# Restore transform
			body.global_position = current_position
			body.global_rotation = current_rotation

			# Enable physics and gravit
			body.freeze = false
			body.gravity_scale = 1
			clicked = true
