extends Node2D

const ENEMY_LENNY = preload("res://enemy_lenny.tscn")
const ENEMY_TROLL = preload("res://enemy_troll.tscn")
const ENEMY_VIRUS = preload("res://enemy_virus.tscn")
const PI_ENEMY = preload("res://pi_enemy.tscn")
const ENEMY_ANON = preload("res://enemy_anon.tscn")
var new_mob = ENEMY_LENNY.instantiate()


func _ready() -> void:
	GameData.checkinvstate = true
	$transition/ColorRect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	%Health.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$CanvasLayer/white.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$CanvasLayer/black.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$staticCanvasLayer/ColorRect.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _process(float) -> void:
	if (GameData.inventory != null && GameData.player != null && GameData.checkinvstate==true):
		GameData.restore_weapon_state()
		GameData.checkinvstate = false

func _on_player_health_depleted() -> void:
	pass

func spawn_mob():
	var choice = randi() % 5  # Generate a random number between 0 and 4
	match choice:
		0:
			new_mob = ENEMY_LENNY.instantiate()
		1:
			new_mob = ENEMY_TROLL.instantiate()
		2:
			new_mob = ENEMY_LENNY.instantiate()
		3:
			new_mob = ENEMY_ANON.instantiate()
		4:
			new_mob = PI_ENEMY.instantiate()
	
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
	

func _on_spawn_timer_2_timeout() -> void:
	spawn_mob()
