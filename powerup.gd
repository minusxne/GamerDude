extends Area2D

@onready var gun = get_node("/root/Game/Player/Gun")
@onready var shotgun = get_node("/root/Game/Player/Shotgun")
var picked_up = false

func _physics_process(delta):
	pass

func _on_body_entered(body: Node2D) -> void:
	picked_up = true
	%AnimatedSprite2D.scale = Vector2(2.2, 2.2)
	%AnimatedSprite2D.position = %AnimatedSprite2D.position - Vector2(0, 15)
	%AnimatedSprite2D.play("explode")
	if (gun != null):
		gun.fire_rate_up()
	if (shotgun != null):
		shotgun.fire_rate_up()


func _on_animated_sprite_2d_animation_looped() -> void:
	if (picked_up):
		queue_free()
