extends MenuButton

@onready var player = get_node("/root/Game/Player")

const LASER_PISTOL = preload("res://weapons/laser_pistol.tscn")
const RED_PISTOL = preload("res://weapons/red_pistol.tscn")
const SHOTGUN = preload("res://shotgun.tscn")
const GUN = preload("res://gun.tscn")
const SAWN_OFF = preload("res://sawn_off.tscn")
const MAC_10 = preload("res://mac_10.tscn")
const NURF = preload("res://nurf.tscn")
const BK47 = preload("res://bk_47.tscn")
const POISON_GUN = preload("res://poison_gun.tscn")
var guns = []
var current_gun_id = -1  # Track the currently equipped gun ID

func _ready():
	guns = [
		LASER_PISTOL.instantiate(),
		RED_PISTOL.instantiate(),
		SHOTGUN.instantiate(),
		GUN.instantiate(),
		SAWN_OFF.instantiate(),
		MAC_10.instantiate(),
		NURF.instantiate(),
		BK47.instantiate(),
		POISON_GUN.instantiate()
	]
	
	for gun in guns:
		player.add_child(gun)
		gun.visible = false  # Initially hide all guns
		gun.active = false # Initially deactivate all guns
	
	# Get the popup menu from the MenuButton
	var popup = get_popup()
	
	# Connect the signal for item selection
	popup.id_pressed.connect(_on_item_pressed)


func _on_item_pressed(id: int):
	
	for gun in guns:
		gun.visible = false
		gun.active = false
	
	match id:
		0:
			guns[id].visible = true
			guns[id].active = true
		1:
			guns[id].visible = true
			guns[id].active = true
			
		2:
			guns[id].visible = true
			guns[id].active = true
			guns[id].global_position = player.global_position + Vector2(0, 20)  # Adjust position for shotgun
		3:
			guns[id].visible = true
			guns[id].active = true
		4:
			guns[id].visible = true
			guns[id].active = true
		5:
			guns[id].visible = true
			guns[id].active = true
		6:
			guns[id].visible = true
			guns[id].active = true
		7:
			guns[id].visible = true
			guns[id].active = true
		8:
			guns[id].visible = true
			guns[id].active = true
		_:
			return
	
	current_gun_id = id
