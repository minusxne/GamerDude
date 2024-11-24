extends Node2D

var projectile = load("res://bossprojectile.tscn").instantiate()
@onready var hand1 = $hand1anims/hand1
@onready var hand2 = $hand2anims/hand2
@onready var hand1anim = $hand1anims
@onready var hand2anim = $hand2anims

func _ready() -> void:
	$Shoottimer.start()

func _process(delta: float) -> void:
	pass

func _on_shootingdelay_timeout() -> void:
	projectile = load("res://bossprojectile.tscn").instantiate()
	projectile.position.y = projectile.position.y + 250
	get_tree().root.add_child(projectile)
	var rand = randi() % 4
	if rand == 0:
		projectile.get_node("RigidBody2D/AnimatedSprite2D").animation = "eyeball"
	elif rand == 1:
		projectile.get_node("RigidBody2D/AnimatedSprite2D").animation = "ham"
	elif rand == 2:
		projectile.get_node("RigidBody2D/AnimatedSprite2D").animation = "wrench"
	else:
		projectile.get_node("RigidBody2D/AnimatedSprite2D").animation = "nail"


func _on_shoottimer_timeout() -> void:
	$Shootingdelay.start()
	$Shoottimer2.start()
	$Shoottimer.stop()

func _on_shoottimer_2_timeout() -> void:
	$Shootingdelay.stop()
	$Shoottimer.start()
	$Shoottimer2.stop()
