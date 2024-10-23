extends CharacterBody2D

signal health_depleted

var health = 100.0
var last_direction = Vector2(0, 1)
var damage_timer = 0.0
const damage_interval = 0.5
const damage_rate = 5


func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 500
	move_and_slide()
	animations()
	var overlapping_bodies = %HurtBox.get_overlapping_bodies()
	damage_timer -= delta
	if damage_timer <= 0:
		if overlapping_bodies.size() > 0:
			%Health.value -= damage_rate * overlapping_bodies.size()
			if %Health.value <= 0:
				game_over()
		damage_timer = damage_interval

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

func game_over():
	print("Game Over")
