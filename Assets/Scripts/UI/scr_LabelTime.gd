extends Label
var time = 5 * 60

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time -= delta
	Globals.time = 5 * 60 - time
	var timeCalc = time
	var minutes = floori(timeCalc / 60.0)
	timeCalc -= 60 * minutes
	var seconds = floori(timeCalc)
	
	var txt = "0"
	txt += str(minutes)
	txt += ":"
	if seconds > 9:
		txt += str(seconds) 
	else:
		txt += "0" + str(seconds)
	text = txt
	
	if time <= 0:
		Globals.WinGame()
