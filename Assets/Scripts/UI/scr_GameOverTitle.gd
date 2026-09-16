extends Label

func StoreData():
	var userId = str(randi())
	
	var hot_path = "user://savedata/hot/" + userId + "health_over_time.csv"
	var hot = FileAccess.open(hot_path, FileAccess.WRITE)
	hot.store_csv_line(Globals.health_over_time)
	
	var uot_path = "user://savedata/uot/" + userId + "upgrades_over_time.csv"
	var uot = FileAccess.open(uot_path, FileAccess.WRITE)
	uot.store_csv_line(Globals.upgrades_over_time)
	
	var epl_path = "user://savedata/epl/" + userId + "enemies_per_level.csv"
	var epl = FileAccess.open(epl_path, FileAccess.WRITE)
	epl.store_csv_line(Globals.enemies_killed_per_level)
	
	var misc_path = "user://savedata/misc/" + userId + "misc.csv"
	var misc = FileAccess.open(misc_path, FileAccess.WRITE)
	
	var enemies_killed_total = 0
	for key in Globals.enemies_killed.keys():
		enemies_killed_total += Globals.enemies_killed[key]
		
	var misc_data = [round(Globals.time), enemies_killed_total, Globals.won, Globals.level, Globals.starter_weapon, Globals.totalXp, Globals.wave]
	misc.store_csv_line(misc_data)
	
func _ready() -> void:
	if Globals.won:
		text = "You Win"
	else:
		text = "Game Over"
		
	StoreData()
	# Add currency
	Globals.currency += Globals.wave - 1
	
	# Reset game variables
	Globals.wave = 1
	Globals.health = Globals.max_health
	Globals.enemies_left = 0
	Globals.level = 0
	Globals.time = 0
	Globals.xp = 0
	Globals.won = false
	
	# Reset upgrade variables
	Globals.damage_multiplier = 1
	Globals.base_health = 0
	Globals.health_multiplier = 1
	Globals.attack_speed_multiplier = 1
	Globals.movement_speed_multiplier = 1
	Globals.add_health_regen = 0
	
	# Reset tracking variables
	Globals.health_over_time = []
	Globals.enemies_killed_per_level = []
	Globals.upgrades = []
	Globals.level_gained = false
	Globals.intermittent_enemies_killed = 0
	Globals.upgrades_over_time = []
	Globals.totalXp = 0
	Globals.enemies_killed = {"square":0, "circle":0, "triangle":0}
