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
@onready var animated_sprite = $AnimatedSprite2D
@onready var explosion_particles = GPUParticles2D.new()

func _ready():
	# Set up explosion particles
	add_child(explosion_particles)
	explosion_particles.emitting = false
	explosion_particles.amount = 20
	explosion_particles.lifetime = 0.4
	explosion_particles.explosiveness = 1.0
	explosion_particles.one_shot = true
	
	# Create and configure particle material
	var particle_material = ParticleProcessMaterial.new()
	
	
	
	particle_material.emission_shape = ParticleProcessMaterial.EMISSION_SHAPE_BOX
	particle_material.particle_flag_disable_z = true
	particle_material.emission_shape_scale.x = 16
	particle_material.emission_shape_scale.y = 16
	particle_material.direction = Vector3(0, -1, 0)
	particle_material.spread = 180.0
	particle_material.initial_velocity_min = 300.0
	particle_material.initial_velocity_max = 500.0
	particle_material.gravity = Vector3(0, 2000, 0)
	particle_material.scale_min = 1.0
	particle_material.scale_max = 1.5
	
	explosion_particles.process_material = particle_material

func _physics_process(_delta: float) -> void:
	if knockback:
		velocity = knockback_dir * knockback_strength
		move_and_slide()
		play_animation()
	else:
		dir = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = dir * speed
		move_and_slide()
		play_animation()

func play_animation():
	if velocity.x > 0 && !knockback:  # Moving right
		animated_sprite.play("default_right")
	elif velocity.x < 0 && !knockback:  # Moving left
		animated_sprite.play("default_left")
	elif velocity.x > 0 && knockback:  # kb right
		animated_sprite.play("hurt_left")
	elif velocity.x < 0 && knockback:  # kb left
		animated_sprite.play("hurt_right")

func take_damage():
	is_damaged = true
	health -= 1
	knockbackenemy()
	$DamageAnimTimer.start()
	if health == 0:
		explode()

func explode():
	# Update particle texture based on current sprite frame
	var sprite_texture = animated_sprite.sprite_frames.get_frame_texture(
		animated_sprite.animation, 
		animated_sprite.frame
	)
	explosion_particles.texture = preprocess_texture(sprite_texture)
	
	# Hide the original sprite
	animated_sprite.visible = false
	
	# Disable collision and physics process
	set_physics_process(false)
	$CollisionShape2D.set_deferred("disabled", true)
	
	# Start explosion
	explosion_particles.emitting = true
	
	# Setup fading effect
	var fade_timer = Timer.new()
	add_child(fade_timer)
	fade_timer.wait_time = explosion_particles.lifetime / 100  # Adjust division factor as needed for speed
	fade_timer.one_shot = false
	fade_timer.start()
	
	# Connect the timer signal to reduce opacity
	fade_timer.timeout.connect(func():
		var current_color = explosion_particles.modulate
		var new_alpha = max(0, current_color.a - 0.01)  # Adjust decrement for fade speed
		explosion_particles.modulate = Color(current_color.r, current_color.g, current_color.b, new_alpha)
		
		if new_alpha <= 0:
			fade_timer.stop()  # Stop once fully transparent
			queue_free()  # Free the node after fading out
	)
	# Queue free after particles finish emitting
	var lifetime_timer = get_tree().create_timer(explosion_particles.lifetime)
	lifetime_timer.timeout.connect(func(): fade_timer.stop())


func preprocess_texture(texture: Texture2D) -> Texture2D:
	var image = Image.create(4, 4, false, Image.FORMAT_RGBA8)
	
	image.fill(Color(1, 1, 1, 1)) 
	
	return ImageTexture.create_from_image(image)


func knockbackenemy():
	knockback = true
	knockback_dir = dir * -1

func makepath() -> void:
	nav_agent.target_position = player.global_position

func _on_timer_timeout() -> void:
	makepath()

func _on_damage_anim_timer_timeout() -> void:
	knockback = false
