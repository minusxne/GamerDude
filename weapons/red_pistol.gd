extends Area2D

var shootcooldown = false
var flipped = false
@onready var mouse_position = get_global_mouse_position()
@onready var player = get_node("/root/Game/Player")
@onready var marker = %ShootingPoint
@onready var pistol = %Pistol
@onready var marker_offset_y = marker.position.y - 0

func _ready():
	add_to_group("guns")

func _physics_process(delta):
	mouse_position = get_global_mouse_position()
	look_at(mouse_position)
	flipGun()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && shootcooldown == true:
		shoot()
		shootcooldown = false

func shoot():
	#pistol.play("shoot")
	pistol.frame = 0
	const BULLET = preload("res://weapons/bullets/red_bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = marker.global_position
	new_bullet.global_rotation = marker.global_rotation
	marker.add_child(new_bullet)


func flipGun():
	var should_flip = mouse_position.x < player.global_position.x
	pistol.flip_v = should_flip
	
	if flipped:
		marker.position.y = -marker_offset_y
	else:
		marker.position.y = marker_offset_y
	
	flipped = should_flip
	
	if (should_flip != flipped):
		pistol.flip_v = should_flip
	

func fire_rate_up():
	%Timer.wait_time = %Timer.wait_time - 0.05

func _on_timer_timeout() -> void:
	shootcooldown = true
	$Timer.start()


func _on_animated_sprite_2d_animation_looped() -> void:
	%Pistol.play("default")
