extends Button

func _pressed() -> void:
	get_tree().paused = false
	Globals.LoseGame()
