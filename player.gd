extends CharacterBody2D

signal health_depleted

var health = 100

func _physics_process(delta):
	#move_and_collide(velocity * delta)
	move_and_slide()
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 600
	
	const DAMAGE_RATE = 5.0
	
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size()>0:
		health-=DAMAGE_RATE*overlapping_mobs.size()*delta
		%ProgressBar.value=health
		if health <= 0:
			health_depleted.emit()
