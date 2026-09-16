extends Button
var data
# Refers to the upgrade cards title label and changes it to the upgrades name
@onready var title = $"VBoxContainer/mar_UpgradeName/lbl_UpgradeTitle"
# Refers to the upgrade cards imagebox and changes it to the upgrades icon
@onready var image: TextureRect = $"VBoxContainer/mar_UpgradeIcon/img_UpgradeIcon"
# Refers to the upgrade cards description label and changes it to the upgrades description
@onready var description = $"VBoxContainer/mar_UpgradeEffect/lbl_UpgradeDescription"
# Refers to the levelstars at the bottom of the upgrade cards
@onready var levelStars = $"VBoxContainer/MarginContainer_level/HBoxContainer"
# Refers to the statmenus gridcontainer that shows what upgrades were picked
@onready var upgradesPicked = $"/root/Node2D/can_StatMenu/scn_StatMenu/HBoxContainer/PanelContainer2/characterStats_MarginContainer/VBoxContainer2/chosenUpgrades_Grid"
# Refers to weapons unlocked in stat menu
@onready var weaponsUnlocked = $"Node2D/can_StatMenu/scn_StatMenu/HBoxContainer/PanelContainer2/characterStats_MarginContainer/VBoxContainer2/MarginContainer/HBox_upgrades/VBox_weapons/lbl_weaponsUnlocked"
func _ready() -> void: # Placeholder for testing layout
	title.text = "Bonk" 
	image.texture = PlaceholderTexture2D.new()
	description.text = "Stat: +/- x\nStat2: +/. x%"
	
func update(): # Gets det upgradechoices meta data to display things like title, description and icon depending on the upgrade
	data = get_meta("Data")
	title.text = data["title"]
	description.text = data["description"]
	image.texture = load(data["icon"])
	
	
	
	for star in range (data["level"]): # This for-loop creates n filled levelStars depending og the level of the upgrade
		# and creates x empty stars depending on the upgrades maxlevel - level
		var filledStar = TextureRect.new()
		filledStar.texture = load("res://Assets/Textures/Upgrade/star_filled.png")
		filledStar.size_flags_horizontal = TextureRect.PRESET_MODE_KEEP_SIZE 
		filledStar.size_flags_vertical = Control.SIZE_FILL 
		filledStar.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		filledStar.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		levelStars.add_child(filledStar)
		
	for star in range (data["maxlevel"]-data["level"]):
		var emptyStar = TextureRect.new()
		emptyStar.texture = load("res://Assets/Textures/Upgrade/star_empty.png") 
		emptyStar.size_flags_horizontal = TextureRect.PRESET_MODE_KEEP_SIZE
		emptyStar.size_flags_vertical = Control.SIZE_FILL 
		emptyStar.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		emptyStar.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		levelStars.add_child(emptyStar)
		
		
func _pressed():
	$"../../..".levelIncrease(data["id"])
	for key in data.keys(): # Checks all keys in data and looks for the correct upgrade key
		match key:
			"damage":
				Globals.damage_multiplier += data[key] # If damage key is found, add key value to damage_multiplier and break.
				break
			"attackspeed":
				Globals.attack_speed_multiplier += data[key] # If attackspeed key is found, add key value to attack speed multiplier
				break
			"health":
				Globals.health_multiplier += data[key] # If health key is found, add key value to health multiplier
				break
			"basehealth":
				#Iif basehealth key is found, add key value to basehealth multiplier
				Globals.health += data[key] * Globals.health_multiplier; Globals.max_health += data[key] * Globals.health_multiplier 
				break
			"healthregen":
				Globals.add_health_regen += data[key] # If healthregen key is found, add key value to health regen variable
				break
			"movementspeed":
				Globals.movement_speed_multiplier += data[key] # If movementspeed key is found, add key value to movement speed multiplier
				break
			"weapon_id":
				$"/root/Node2D/obj_Player".Equip(data[key])
				break
	
	var upgradeBox = VBoxContainer.new()
	var titleContainer = MarginContainer.new()
	var upgradeTitle = Label.new()
	var upgradeIcon = TextureRect.new()
	
	# Set specific sizes for objects to align properly in grid
	upgradeBox.custom_maximum_size = Vector2(50,65)
	upgradeBox.custom_minimum_size = Vector2(50,65)
	titleContainer.custom_maximum_size = Vector2(50,15)
	titleContainer.custom_minimum_size = Vector2(50,15)
	upgradeIcon.custom_maximum_size = Vector2(50,50)
	
	upgradeTitle.add_theme_font_size_override("font_size",15) # Sets font size to 15 so text shows
	upgradeTitle.size_flags_horizontal = Label.SIZE_EXPAND_FILL
	upgradeTitle.size_flags_vertical = Label.SIZE_EXPAND_FILL
	# Adds the three objects as parents under either gridcontainer og newly created VBoxContainer
	upgradesPicked.add_child(upgradeBox)
	upgradeBox.add_child(titleContainer)
	titleContainer.add_child(upgradeTitle)
	upgradeBox.add_child(upgradeIcon)
	
	upgradeTitle.text = data["title"]
	upgradeIcon.texture = load(data["icon"])
	
	
	$"../../../..".HideUpgrades()
