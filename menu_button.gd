extends MenuButton

@onready var player = get_node("/root/Game/Player")

func _ready():
	# Get the popup menu from the MenuButton
	var popup = get_popup()
	
	# Connect the signal for item selection
	popup.id_pressed.connect(_on_item_pressed)

func _on_item_pressed(id: int):
	match id:
		0:
			get_tree().call_group("guns", "queue_free")
			const laser_pistol = preload("res://weapons/laser_pistol.tscn")
			var new_gun = laser_pistol.instantiate()
			player.add_child(new_gun)
			#new_gun.global_position = player.global_position
		1:
			get_tree().call_group("guns", "queue_free")
			const red_pistol = preload("res://weapons/red_pistol.tscn")
			var new_gun = red_pistol.instantiate()
			player.add_child(new_gun)
			#new_gun.global_position = player.global_position
		_:
			pass
