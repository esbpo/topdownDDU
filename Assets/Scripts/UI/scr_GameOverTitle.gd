extends Label

func _ready() -> void:
	if Globals.won:
		text = "You Win"
	else:
		text = "Game Over"
		
	Globals.currency += Globals.wave - 1
