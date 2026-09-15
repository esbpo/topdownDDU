extends Label


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = ""
	text += "Health: " + str(Globals.health_multiplier) + "x\n"
	text += "Damage: " + str(Globals.damage_multiplier) + "x\n"
	text += "Attack speed: " + str(Globals.attack_speed_multiplier) + "x\n"
	text += "Movement speed: " + str(Globals.movement_speed_multiplier) + "x\n"
