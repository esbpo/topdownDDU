extends CanvasLayer
var instance
@onready var scene = preload("res://scn_ChooseUpgrade.tscn")
@onready var UpgradeJson: String = FileAccess.get_file_as_string("res://Data/Upgrades.json")
@onready var WeaponUnlockJson : String = FileAccess.get_file_as_string("res://Data/WeaponUnlocks.json")

var weaponUnlockDict: Dictionary
var upgradeDict: Dictionary
var upgradesAvailable 
var weaponsAvailable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	upgradeDict = JSON.parse_string(UpgradeJson)
	upgradesAvailable = len(upgradeDict)
	weaponUnlockDict = JSON.parse_string(WeaponUnlockJson)
	weaponsAvailable = len(weaponUnlockDict)
	

func ShowUpgrades(): 
	instance = scene.instantiate()
	add_child(instance)
	instance.Upgrade()
	visible = true
	#Pauses the game so player has time to think when choosing
	get_tree().paused = true #Also works to stop upgrade choices overlapping if player somehow levels up twice
	
	
func HideUpgrades():
	instance.queue_free()
	visible = false
	get_tree().paused = false
