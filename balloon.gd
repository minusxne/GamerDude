extends RigidBody2D

var travelled_distance = 0
var max_bounces = 5
var bounces = 0
var rotatecheck = false
var range = 1500
var speed = 750
var bounce_factor = 1
var bounced = false

# TODO: fix sprite rotation according to velocity angle debugging

func _ready() -> void:
	# Using linear_velocity instead of manually setting velocity
	%AnimatedSprite2D.modulate = Color(1, 1, 1).from_hsv(randf(), 1, 1)
	linear_velocity = Vector2(speed, 0).rotated(rotation)
	max_contacts_reported = 4
	contact_monitor = true
	lock_rotation = true
	physics_material_override.friction = 0.0  # Reduce friction
	gravity_scale = 0.0  # Optional: disable gravity if you don't want it

func _physics_process(delta):
	# Track distance traveled using the actual movement
	travelled_distance += linear_velocity.length() * delta
	var velocity = linear_velocity
	if (bounced && rotatecheck):
		#TODO: fix this so that it bounces with a 180 degree offset when bouncing down
		%AnimatedSprite2D.rotate(randf_range(1, 180))
		rotatecheck = false
	if travelled_distance > range:
		queue_free()
	

func _on_body_entered(body):
	bounced = true
	#if ((linear_velocity < Vector2(0,100) || linear_velocity < Vector2(100,0)) && (linear_velocity > Vector2(0,-100) || linear_velocity > Vector2(-100,0))):
		#queue_free()
	if body.is_in_group("character"):
		linear_velocity=Vector2(0,0)
		explode()
	if body.has_method("take_damage"):
		linear_velocity=Vector2(0,0)
		explode()
		body.take_damage()
		body.take_damage()
	if (bounces == max_bounces):
		linear_velocity=Vector2(0,0)
		explode()
	bounces += 1
	rotatecheck = true

func explode():
	%Timer.start()
	%AnimatedSprite2D.play("explode")
	%AnimatedSprite2D.scale = Vector2(1,1)

func _on_timer_timeout() -> void:
	queue_free()
