extends Button
var data
#refers to the upgrade cards title label and changes it to the upgrades name
@onready var title = $"VBoxContainer/mar_UpgradeName/lbl_UpgradeTitle"
#refers to the upgrade cards imagebox and changes it to the upgrades icon
@onready var image: TextureRect = $"VBoxContainer/mar_UpgradeIcon/img_UpgradeIcon"
#refers to the upgrade cards description label and changes it to the upgrades description
@onready var description = $"VBoxContainer/mar_UpgradeEffect/lbl_UpgradeDescription"
#refers to the levelstars at the bottom of the upgrade cards
@onready var levelStars = $"VBoxContainer/MarginContainer_level/HBoxContainer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	title.text = "Bonk" 
	image.texture = PlaceholderTexture2D.new()
	description.text = "Stat: +/- x\nStat2: +/. x%"
	
	
	
func update():
	data = get_meta("Data")
	print(data)
	title.text = data["title"]
	description.text = data["description"]
	image.texture = load(data["icon"])
	
	for star in range (data["level"]): #this for loop creates n filled levelStars depending og the level of the upgrade
		#and creates x empty stars depending on the upgrades maxlevel - level
		var filledStar = TextureRect.new()
		filledStar.texture = load("res://Assets/Textures/Upgrade/star_filled.png")
		filledStar.size_flags_horizontal = Control.SIZE_FILL | Control.SIZE_EXPAND
		filledStar.size_flags_vertical = Control.SIZE_FILL
		filledStar.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		filledStar.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
		levelStars.add_child(filledStar)
		
	for star in range (data["maxlevel"]-data["level"]):
		var emptyStar = TextureRect.new()
		emptyStar.texture = load("res://Assets/Textures/Upgrade/star_empty.png") #
		emptyStar.size_flags_horizontal = Control.SIZE_FILL | Control.SIZE_EXPAND
		emptyStar.size_flags_vertical = Control.SIZE_FILL
		emptyStar.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		emptyStar.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
		levelStars.add_child(emptyStar)
		
		
func _pressed():
	$"../../..".levelIncrease(int(data["id"]))
	for key in data.keys(): #Checks all keys in data and looks for the correct upgrade key
		match key:
			"damage":
				Globals.damage_multiplier += data[key] #if damage key is found, add key value to damage_multiplier and break.
				break
			"attackspeed":
				Globals.attack_speed_multiplier += data[key] #if attackspeed key is found, add key value to attack speed multiplier
				break
			"health":
				Globals.health_multiplier += data[key] #if health key is found, add key value to health multiplier
				break
			"basehealth":
				Globals.add_base_health += data[key] #if basehealth key is found, add key value to basehealth multiplier
				break
			"healthregen":
				Globals.add_health_regen += data[key] #if healthregen key is found, add key value to health regen variable
				break
			"movementspeed":
				Globals.movement_speed_multiplier += data[key] #if movementspeed key is found, add key value to movement speed multiplier
				break
