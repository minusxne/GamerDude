# unused

extends Area2D

var travelled_distance = 0
var range = 1200
var speed = 1000
var velocity = Vector2.ZERO
var bounce_factor = 0.9  # Reduced slightly to prevent endless bouncing

func _ready():
	velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	# Move bullet by velocity and update position
	var movement = velocity * delta
	position += movement
	
	# Track distance traveled and queue free if out of range
	travelled_distance += movement.length()
	if travelled_distance > range:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	# Assuming `self` is an Area2D with a velocity property and a bounce_factor property
	# Get the normal of the collision from the collision shape
	var collision_shape = $CollisionShape2D.shape
	if collision_shape:
		# Calculate the normal at the point of collision
		var collision_point = body.global_position - global_position
		var collision_normal = collision_point.normalized()
		# Reflect the velocity over the collision normal
		velocity = velocity.bounce(collision_normal) * bounce_factor
	# Check for a damage-taking function on the hit body
	if body.has_method("take_damage"):
		body.take_damage()

func _on_timer_timeout() -> void:
	queue_free()
