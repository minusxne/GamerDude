extends CharacterBody2D

signal health_depleted

var health = 100.0
var last_direction = Vector2(0, 1)
var damage_timer = 0.0
var speed = 450
const damage_interval = 0.5
const damage_rate = 5

func _ready() -> void:
	add_to_group("character")

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
	animations()
	cameraoffset()
	var overlapping_bodies = %HurtBox.get_overlapping_bodies()
	damage_timer -= delta
	if damage_timer <= 0:
		if overlapping_bodies.size() > 0:
			%Health.value -= damage_rate * overlapping_bodies.size()
			if %Health.value <= 0:
				game_over()
		damage_timer = damage_interval

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

func increase_speed():
	speed = speed + 25

func increase_dps():
	 # List of valid gun names
	var gun_names = ["red_pistol", "laser_pistol", "Shotgun", "Gun"]
	var decrease_amount = 0.1
	# Loop through each gun name and check if the player node has a matching child
	for gun_name in gun_names:
		if has_node(gun_name):
			var gun_node = get_node(gun_name)
			if gun_node.active:
				decrease_fire_rate(gun_node, decrease_amount)

func decrease_fire_rate(gun_node: Node, decrease_amount: float) -> void:
	if gun_node.has_node("Timer"):
		var fire_timer = gun_node.get_node("Timer")
		if fire_timer is Timer:
			fire_timer.wait_time = max(0.1, fire_timer.wait_time - decrease_amount)
			fire_timer.start()
		else:
			print("Error: Timer node is not of type Timer")
	else:
		print("Error: No Timer node found in gun")


func cameraoffset():
	$Camera2D.offset = (get_global_mouse_position() - global_position) * 0.10

func game_over():
	print("Game Over")
