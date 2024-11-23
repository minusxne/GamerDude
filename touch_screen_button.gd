extends TouchScreenButton

@onready var animationplayer = $".."

func _on_pressed():
	if animationplayer:
		animationplayer.play("play")
