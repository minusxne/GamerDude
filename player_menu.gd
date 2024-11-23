extends CharacterBody2D

signal health_depleted

var health = GameData.health
var last_direction = Vector2(0, 1)
var damage_timer = 0.0
var speed = 2000
const damage_interval = 0.5
const damage_rate = 5
var pressed = false

func _ready() -> void:
	pass

func _physics_process(delta):
	if pressed:
		position.x+=35
		$Player_Sprite.play("walk_right")
	else:
		move_and_slide()
		animations()
	move_and_slide()


func animations():
	
	if velocity.length() > 10:
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
