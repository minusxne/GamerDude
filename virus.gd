extends CharacterBody2D

var player 
var knockback = false
var is_damaged = false
var health = 100
var knockback_strength = 100  # Adjust this value to change knockback strength
var normal_speed = 100  # Normal movement speed
var knockback_dir = Vector2.ZERO

func _ready():
	player = get_node("/root/Game/Player")

func _physics_process(delta):
	var direction = Vector2.ZERO
	
	if knockback:
		velocity = knockback_dir * knockback_strength / 80
	else:
		direction = global_position.direction_to(player.global_position)
		velocity = direction * normal_speed / 80
	play_walk_animation()
	move_and_collide(velocity)

func play_walk_animation():
	if velocity.x > 0 && !knockback:  # Moving right
		$AnimatedSprite2D.play("default_right")
	elif velocity.x < 0 && !knockback:  # Moving left
		$AnimatedSprite2D.play("default_left")
	elif velocity.x > 0 && knockback:  # kb right
		$AnimatedSprite2D.play("damage_left")
	elif velocity.x < 0 && knockback:  # kb left
		$AnimatedSprite2D.play("damage_right")

func take_damage():
	is_damaged = true
	health -= 1
	$DamageAnimTimer.start()
	if health == 0:
		queue_free()
	knockbackenemy()

func knockbackenemy():
	knockback = true
	knockback_dir = global_position.direction_to(player.global_position).normalized() * -1

func _on_timer_timeout() -> void:
	knockback = false
