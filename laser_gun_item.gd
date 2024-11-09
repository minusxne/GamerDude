extends Area2D

@onready var player = get_node("/root/Game/Player")
@onready var inventory = get_node("/root/Game/staticCanvasLayer/MenuButton")
var picked_up = false

func _physics_process(delta):
	pass

func _on_body_entered(body: Node2D) -> void:
	if (%item!=null):
		%item.scale = Vector2(2.2, 2.2)
		%item.position = %item.position - Vector2(0, 15)
		%item.play("explode")
		%CollisionShape2D.queue_free()
	picked_up = true
	if (%pickupeffect != null):
		%pickupeffect.play("default")
	addweapon()

func addweapon():
	inventory._on_item_pressed(0)

func _on_pickupeffect_animation_looped() -> void:
	%pickupeffect.queue_free()

func _on_item_animation_looped() -> void:
	if (picked_up):
		%item.queue_free()
		queue_free()
