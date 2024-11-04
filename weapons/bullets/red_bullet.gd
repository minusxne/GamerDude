extends Area2D

var travelled_distance = 0
var range = 1200
var speed = 1000
var velocity = Vector2.ZERO
var bounce_factor = 0.9  # Reduced slightly to prevent endless bouncing

# TODO: fix broken bouncing mechanic that goes through tilemap walls

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
	# Check if the bullet hit a horizontal or vertical surface and adjust accordingly
	if abs(velocity.x) > abs(velocity.y):
		# If moving horizontally, invert x-component for horizontal bounce
		velocity.x = -velocity.x * bounce_factor
	else:
		# If moving vertically, invert y-component for vertical bounce
		velocity.y = -velocity.y * bounce_factor

	# Check for a damage-taking function on the hit body
	if body.has_method("take_damage"):
		body.take_damage()

func _on_timer_timeout() -> void:
	queue_free()
