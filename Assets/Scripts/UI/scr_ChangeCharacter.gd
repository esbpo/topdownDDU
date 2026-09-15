extends Button

@export var speed: int
@export var health: int
@export var price: int
@export var weapon: int
@export var skin: String

@onready var selectedStyle: StyleBox = preload("res://Assets/Resources/UI/res_MenuButtonBase.tres")
@onready var baseStyle: StyleBox = preload("res://Assets/Resources/UI/res_UpgradeBase.tres")
@onready var hoverStyle: StyleBox = preload("res://Assets/Resources/UI/res_MenuButtonHover.tres")

func _process(_delta: float) -> void:
	if Globals.starter_weapon == weapon:
		add_theme_stylebox_override("normal", selectedStyle)
	else:
		remove_theme_stylebox_override("normal")
		add_theme_stylebox_override("normal", baseStyle)
		
	if not weapon in Globals.unlocked_characters and Globals.currency < price:
		disabled = true
	elif not weapon in Globals.unlocked_characters and Globals.currency >= price:
		disabled = false
		add_theme_stylebox_override("hover", hoverStyle)
		add_theme_stylebox_override("pressed", hoverStyle)
	else:
		disabled = false
		add_theme_stylebox_override("normal", baseStyle)
		add_theme_stylebox_override("hover", hoverStyle)
		add_theme_stylebox_override("pressed", hoverStyle)
	
func _pressed() -> void:
	if Globals.currency >= price and not weapon in Globals.unlocked_characters:
		Globals.currency -= price
		Globals.unlocked_characters.append(weapon)
	
	if weapon in Globals.unlocked_characters:
		Globals.speed = speed
		Globals.health = health
		Globals.starter_weapon = weapon
		Globals.player_skin = skin
