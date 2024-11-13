extends Area2D

var travelled_distance = 0
var speedvar = 1

func _physics_process(delta):
	const SPEED = 300
	const RANGE = 750
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction*SPEED*delta * speedvar
	speedvar -= 0.005
	%Projectile.modulate.a -= 0.01
	%Projectile.scale.x += 0.025
	%Projectile.scale.y += 0.025
	travelled_distance+=SPEED*delta
	if travelled_distance>RANGE:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage()
		body.take_damage()
		body.take_damage()
		body.take_damage()
		body.take_damage()
		body.take_damage()
