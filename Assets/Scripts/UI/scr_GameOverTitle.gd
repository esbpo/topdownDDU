extends Label

func StoreData():
	var health_over_time = FileAccess.open("user://health_over_time.csv", FileAccess.WRITE)
	

func _ready() -> void:
	if Globals.won:
		text = "You Win"
	else:
		text = "Game Over"
		
	Globals.currency += Globals.wave - 1
	Globals.wave = 1
	Globals.health = Globals.max_health
	Globals.enemies_left = 0
	Globals.damage_multiplier = 1
	Globals.base_health = 0
	Globals.health_multiplier = 1
	Globals.attack_speed_multiplier = 1
	Globals.movement_speed_multiplier = 1
	Globals.add_health_regen = 0
	Globals.level = 0
	Globals.time = 0
	Globals.xp = 0
	Globals.won = false
