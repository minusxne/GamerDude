extends Area2D

@onready var player = get_node("/root/Game/Player")

func _physics_process(delta):
	pass

func _transition_to_next_level():
	# Get the current scene
	var current_scene = get_tree().current_scene
	
	# Check if the current scene has a `level` variable
	if current_scene.has_method("get_level"):
		
		var current_level = current_scene.get_level()  # Custom function in level script
		var next_level_scene_path = "res://levels/level" + str(current_level - 1) + ".tscn"
		var next_scene = load(next_level_scene_path)
		print(next_level_scene_path)
		# Load the next scene
		if ResourceLoader.exists(next_level_scene_path):  # Check if the scene exists
			get_tree().change_scene_to_packed(next_scene)

func _on_body_entered(body: Node2D) -> void:
	if body == player:
		_transition_to_next_level()
