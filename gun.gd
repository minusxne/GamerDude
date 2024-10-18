extends Area2D

var shootcooldown = false

func _physics_process(delta):
	var mouse_position = get_global_mouse_position()
	look_at(mouse_position)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && shootcooldown == true:
		shoot()
		shootcooldown = false

func shoot():
	const BULLET = preload("res://bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)


func _on_timer_timeout() -> void:
	shootcooldown = true
	$Timer.start()
