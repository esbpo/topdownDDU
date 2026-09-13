extends Control

func ShowStatMenu():
	visible = true
	get_tree().paused = true
	
func HideStatMenu():
	visible = false
	get_tree().paused = false
