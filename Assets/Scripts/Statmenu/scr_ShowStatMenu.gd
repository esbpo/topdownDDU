extends CanvasLayer


func ShowStatMenu():
	visible = true
	get_tree().paused = true
	
func HideStatMenu():
	visible = false
	get_tree().paused = false

func _input(event):
	if visible == true:
		if event.is_action_pressed("ui_close_dialog"):
			HideStatMenu()
