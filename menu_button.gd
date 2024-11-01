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
			print("Option 1 was selected!")
		1:
			print("Option 2 was selected!")
		_:
			print("Unknown option selected!")
