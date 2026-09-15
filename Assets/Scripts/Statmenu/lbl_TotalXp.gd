extends Label



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = "Total xp: " + str(int(Globals.totalXp))
