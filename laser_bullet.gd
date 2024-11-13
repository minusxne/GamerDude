extends Area2D

var travelled_distance = 0
var SPEED = 1000
var RANGE = 1200

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction*SPEED*delta
	travelled_distance+=SPEED*delta
	if travelled_distance>RANGE:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	$Timer.start()
	SPEED=0
	%Projectile.play("explode")
	%Projectile.scale = Vector2(1, 1)
	if body.has_method("take_damage"):
		body.take_damage()
		body.take_damage()
		body.take_damage()
		body.take_damage()


func _on_timer_timeout() -> void:
	queue_free()
