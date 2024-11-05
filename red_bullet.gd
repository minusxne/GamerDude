extends RigidBody2D

var travelled_distance = 0
var max_bounces = 5
var bounces = 0
var range = 750
var speed = 1200
var bounce_factor = 0.9
var bounced = false

# TODO: fix sprite rotation according to velocity angle debugging

func _ready() -> void:
	# Using linear_velocity instead of manually setting velocity
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
	if (bounced):
		#TODO: fix this so that it bounces with a 180 degree offset when bouncing down
		$AnimatedSprite2D.rotation = 2*velocity.angle()
	if travelled_distance > range:
		queue_free()

func _on_body_entered(body):
	bounced = true
	#if ((linear_velocity < Vector2(0,100) || linear_velocity < Vector2(100,0)) && (linear_velocity > Vector2(0,-100) || linear_velocity > Vector2(-100,0))):
		#queue_free()
	if body.is_in_group("character"):
		queue_free()
	if body.has_method("take_damage"):
		queue_free()
		body.take_damage()
		body.take_damage()
	if (bounces == max_bounces):
		queue_free()
	bounces += 1
