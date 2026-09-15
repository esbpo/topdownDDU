extends Label

func _process(_delta: float) -> void:
	text = "x" + str(int(Globals.currency))
