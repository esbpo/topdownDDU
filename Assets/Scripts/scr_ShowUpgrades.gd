extends CanvasLayer
var instance
@onready var scene = preload("res://scn_ChooseUpgrade.tscn")
@onready var UpgradeJson: String = FileAccess.get_file_as_string("res://Data/Upgrades.json")
var upgradeArray: Array
var upgradesAvailable 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	upgradeArray = JSON.parse_string(UpgradeJson)
	upgradesAvailable = len(upgradeArray)


func ShowUpgrades():
	instance = scene.instantiate()
	add_child(instance)
	instance.Upgrade()
	visible = true
	get_tree().paused = true
	
func HideUpgrades():
	instance.queue_free()
	visible = false
	get_tree().paused = false
