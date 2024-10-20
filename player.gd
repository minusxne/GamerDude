extends CharacterBody2D

signal health_depleted

var health = 100
var last_direction = Vector2(0, 1)

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 10
	move_and_collide(velocity)

	const DAMAGE_RATE = 5.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		if health <= 0:
			health_depleted.emit()
	
	animations()

func animations():
	
	if velocity.length() > 0:
		last_direction = velocity.normalized()
		if abs(velocity.x) > abs(velocity.y):
			if velocity.x > 0:
				$Player_Sprite.play("walk_right")
			else:
				$Player_Sprite.play("walk_left")
		else:
			if velocity.y > 0:
				$Player_Sprite.play("walk_down")
			else:
				$Player_Sprite.play("walk_up")
	else:
		if last_direction.x > 0:
			$Player_Sprite.play("default_right")
		elif last_direction.x < 0:
			$Player_Sprite.play("default_left")
		elif last_direction.y > 0:
			$Player_Sprite.play("default_down")
		else:
			$Player_Sprite.play("default_up")
