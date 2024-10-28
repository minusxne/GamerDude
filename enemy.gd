extends CharacterBody2D


var knockback = false
var is_damaged = false
var health = 7
var knockback_strength = 100  # Adjust this value to change knockback strength
var normal_speed = 100  # Normal movement speed
var dir = 1
var knockback_dir = dir * -1
const speed = 150
@onready var player = get_node("/root/Game/Player")
@onready var nav_agent = $"%NavigationAgent2D"

func _physics_process(_delta: float) -> void:
	if knockback:
		velocity = knockback_dir * knockback_strength
		move_and_slide()
		play_animation()
	else:
		dir = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = dir*speed
		move_and_slide()
		play_animation()

func play_animation():
	if velocity.x > 0 && !knockback:  # Moving right
		$AnimatedSprite2D.play("default_right")
	elif velocity.x < 0 && !knockback:  # Moving left
		$AnimatedSprite2D.play("default_left")
	elif velocity.x > 0 && knockback:  # kb right
		$AnimatedSprite2D.play("hurt_left")
	elif velocity.x < 0 && knockback:  # kb left
		$AnimatedSprite2D.play("hurt_right")

func take_damage():
	is_damaged = true
	health -= 1
	knockbackenemy()
	$DamageAnimTimer.start()
	if health == 0:
		queue_free()

func knockbackenemy():
	knockback = true
	knockback_dir = dir * -1

func makepath() -> void:
	nav_agent.target_position = player.global_position

func _on_timer_timeout() -> void:
	makepath()


func _on_damage_anim_timer_timeout() -> void:
	knockback = false
