extends Area2D

var travelled_distance = 0
var RANGE = 1200
var speed = 1000
var velocity = Vector2.ZERO
var bounce_factor = 1.0  # Amount of velocity retained after bouncing (1.0 = full bounce)

func _ready():
	velocity = Vector2(speed, 0).rotated(rotation)

func _process(delta):
	position += velocity * delta
	#var direction = Vector2.RIGHT.rotated(rotation)
	#position += direction*SPEED*delta
	#
	#
	#travelled_distance+=SPEED*delta
	#if travelled_distance>RANGE:
		#queue_free()

func _on_body_entered(body: Node2D) -> void:
	# Get the collision normal (the direction the bullet hit)
	var collision_normal = (body.global_position - global_position).normalized()
	
	# Reflect the velocity to create a bounce effect
	velocity = velocity.bounce(collision_normal) * bounce_factor
	
	#$Timer.start()
	#
	#SPEED=0
	#
	#%Projectile.play("explode")
	#
	#%Projectile.scale = Vector2(0.5, 0.5)
	#
	if body.has_method("take_damage"):
		body.take_damage()
		body.take_damage()

func _on_timer_timeout() -> void:
	queue_free()
