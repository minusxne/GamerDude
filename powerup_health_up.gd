extends Area2D

@onready var player = get_node("/root/Game/Player")
var picked_up = false

func _physics_process(delta):
	pass

func _on_body_entered(body: Node2D) -> void:
	if (%item!=null):
		%item.scale = Vector2(2.2, 2.2)
		%item.position = %item.position - Vector2(0, 15)
		%item.play("explode")
	picked_up = true
	if (%pickupeffect != null):
		%pickupeffect.play("default")
	# increase speed
	player.increase_health()


func _on_animated_sprite_2d_animation_looped() -> void:
	if (picked_up):
		%item.queue_free()
		queue_free()


func _on_pickupeffect_animation_looped() -> void:
	%pickupeffect.queue_free()
