extends Label
var time = 5 * 60
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time -= delta
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
		get_tree().quit()
