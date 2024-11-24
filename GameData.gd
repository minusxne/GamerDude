extends Node

var speed = 450
var health = 100
var lastgun = -1
var checkinvstate = false
var playerdeathpos

@onready var player = get_node("/root/Game/Player")
@onready var inventory = get_node("/root/Game/staticCanvasLayer/MenuButton")

func _process(delta: float) -> void:
	if checkinvstate:
		player = get_node("/root/Game/Player")
		inventory = get_node("/root/Game/staticCanvasLayer/MenuButton")

func remember_weapon(gun_name: int):
	lastgun = gun_name  # Save the last used gun
	checkinvstate = true

func restore_weapon_state():
	if (lastgun > -1):
		inventory._on_item_pressed(lastgun)

func deathscreen():
	var death_scene: PackedScene = preload("res://death_menu.tscn")
	get_tree().change_scene_to_packed(death_scene)

func increasegundps():
	var gun_names = ["red_pistol", "laser_pistol", "Shotgun", "Gun", "SawnOff", "mac_10", "bk47", "nurf", "golden_gun", "poison_gun"]
	var decrease_amount = 0.1
	# Loop through each gun name and check if the player node has a matching child
	for gun_name in gun_names:
		if player.has_node(gun_name):
			var gun_node = player.get_node(gun_name)
			if gun_node.active:
				player.decrease_fire_rate(gun_node, decrease_amount)
