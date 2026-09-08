extends HSlider

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	value = Globals.health
	max_value = Globals.max_health
