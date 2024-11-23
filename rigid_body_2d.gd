extends RigidBody2D

func _physics_process(delta: float) -> void:
	scale = %CollisionShape2D.current_scale + Vector2(2,2)
	%Sprite2D.scale = %CollisionShape2D.current_scale
