extends CharacterBody2D

var health = 3

@onready var player = get_node("/root/Game/Player")

func _ready():
	%Slime.play_walk();


func _physics_process(delta):
	move_and_collide(velocity * delta)
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 100


func take_damage():
	%Slime.play_hurt();
	health-=1
	if health==0:
		queue_free()
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
