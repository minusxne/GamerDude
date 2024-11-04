extends Area2D

var shootcooldown = false
var flipped = false
var mouse_position = get_global_mouse_position()
@onready var player = get_node("/root/Game/Player")

func _ready():
	add_to_group("guns")

func _physics_process(delta):
	mouse_position = get_global_mouse_position()
	flipGun()
	look_at(mouse_position)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && shootcooldown == true:
		shoot()
		shootcooldown = false

func shoot():
	const BULLET = preload("res://bullet.tscn")
	const BULLET_COUNT = 4  # Number of bullets to shoot (spread)
	const SPREAD_ANGLE = deg_to_rad(20)  # Spread angle in radians (adjust as needed)
	%Shotgun.play("shoot")
	%Shotgun.frame = 0
	for i in range(BULLET_COUNT):
		var new_bullet = BULLET.instantiate()
		new_bullet.global_position = %ShootingPoint.global_position
		# Calculate a random spread by slightly rotating each bullet
		var spread = randf_range(-SPREAD_ANGLE, SPREAD_ANGLE)
		new_bullet.global_rotation = %ShootingPoint.global_rotation + spread
		# Add the bullet to the scene
		%ShootingPoint.add_child(new_bullet)
	

func fire_rate_up():
	%Timer.wait_time = %Timer.wait_time - 0.10
	print(%Timer.wait_time)

func flipGun():
	var should_flip = mouse_position.x < player.global_position.x
	
	if (should_flip != flipped):
		%Shotgun.flip_v = should_flip
		flipped = should_flip
	

func _on_timer_timeout() -> void:
	shootcooldown = true
	$Timer.start()


func _on_shotgun_animation_looped() -> void:
	%Shotgun.play("default")
