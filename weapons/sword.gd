extends Node2D

@onready var AP = %AnimationPlayer
@onready var player = get_node("/root/Game/Player")
@onready var sword = %swordsprite
@onready var flip_offset_x = sword.position.x - 55
@onready var init_pos = Vector2(28, -28)
var mouse_position = get_global_mouse_position()
var swingcooldown = true

func _ready() -> void:
	pass

func swing():
	if (sword.flip_h):
		AP.play("swing_sword_left")
	else:
		AP.play("swing_sword_right")

func flipguncheck():
	var sword_dir = mouse_position.x < player.global_position.x
	sword.flip_h = sword_dir
	if (sword.flip_h):
		sword.position.x = flip_offset_x
	else:
		sword.position = init_pos

func _process(delta: float) -> void:
	mouse_position = get_global_mouse_position()
	flipguncheck()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && swingcooldown == true:
		swing()
		swingcooldown = false


func _on_swing_timer_timeout() -> void:
	swingcooldown = true
	%Timer.start()
