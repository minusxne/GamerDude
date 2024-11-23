extends Area2D

@onready var player = get_node("/root/Game/Player")
@onready var inventory = get_node("/root/Game/staticCanvasLayer/MenuButton")
@onready var transition = %transition
@onready var fadetimer = %FadeTimer
var next_scene: PackedScene = null

func _physics_process(delta):
	
	pass

func _transition_to_next_level():
	# Get the current scene
	var current_scene = get_tree().current_scene
	
	# Check if the current scene has a `level` variable
	if current_scene.has_method("get_level"):
		
		var current_level = current_scene.get_level()  # Custom function in level script
		var next_level_scene_path = "res://levels/level" + str(current_level + 1) + ".tscn"
		next_scene = load(next_level_scene_path)
		# Load the next scene
		if ResourceLoader.exists(next_level_scene_path):  # Check if the scene exists
			GameData.remember_weapon(inventory.current_gun_id)
			fadetimer.start()
			transition.play("fadeout")


func _on_body_entered(body: Node2D) -> void:
	if body == player:
		_transition_to_next_level()


func _on_fade_timer_timeout() -> void:
	get_tree().change_scene_to_packed(next_scene)
