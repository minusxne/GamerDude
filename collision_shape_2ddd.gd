extends CollisionShape2D

@onready var body = $".."
@onready var animationplayer = $"../.."
var clicked = false
@onready var current_scale = body.scale
var lvl1: PackedScene =load("res://levels/level1.tscn")

#??

func _process(delta):
	if clicked:
		animationplayer.play("play")
		%CollisionShape2D.clickforce = true
		$"../../../AnimationPlayer3".play("new_animation")
		
		var timer = Timer.new()
		add_child(timer)
		timer.timeout.connect(func(): get_tree().change_scene_to_packed(lvl1))
		timer.one_shot = true  # Timer runs once and stops
		timer.start(4.0)

	var mouse_pos = get_viewport().get_mouse_position()
	if shape is RectangleShape2D:
		var rect = shape
		var shape_position = global_position
		if mouse_pos.x >= shape_position.x - rect.extents.x and \
		   mouse_pos.x <= shape_position.x + rect.extents.x and \
		   mouse_pos.y >= shape_position.y - rect.extents.y and \
		   mouse_pos.y <= shape_position.y + rect.extents.y and \
		   Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):

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
			clicked = true
