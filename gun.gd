extends Area2D

var shootcooldown = false
var flipped = false
var mouse_position = get_global_mouse_position()
@onready var player = get_node("/root/Game/Player")

func _physics_process(delta):
	mouse_position = get_global_mouse_position()
	look_at(mouse_position)
	flipGun()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && shootcooldown == true:
		shoot()
		shootcooldown = false

func shoot():
	%Pistol.play("shoot")
	%Pistol.frame = 0
	const BULLET = preload("res://bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)

func flipGun():
	var should_flip = mouse_position.x < player.global_position.x
	
	if (should_flip != flipped):
		%Pistol.flip_v = should_flip
		flipped = should_flip
	

func _on_timer_timeout() -> void:
	shootcooldown = true
	$Timer.start()


func _on_animated_sprite_2d_animation_looped() -> void:
	%Pistol.play("default")
