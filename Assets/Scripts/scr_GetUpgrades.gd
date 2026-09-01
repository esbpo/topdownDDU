extends Control
@onready var UpgradeJson: String = FileAccess.get_file_as_string("res://Data/Upgrades.json")
var upgradeArray: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	upgradeArray = JSON.parse_string(UpgradeJson)
	Upgrade()
func Upgrade():
	var upgradeChoices = [randi_range(0, len(upgradeArray)-1), randi_range(0, len(upgradeArray)-1), randi_range(0, len(upgradeArray)-1),]
	
	while upgradeChoices[0] == upgradeChoices[1] or upgradeChoices[0] == upgradeChoices[2]:
		upgradeChoices[0] = randi_range(1, len(upgradeArray)-1)

	while upgradeChoices[1] == upgradeChoices[0] or upgradeChoices[1] == upgradeChoices[2]:
		upgradeChoices[1] = randi_range(1, len(upgradeArray)-1)
	
	var upgrade1 = $"HBox/MarginContainer_Upgrade1/Button"
	var upgrade2 = $"HBox/MarginContainer_Upgrade2/Button"
	var upgrade3 = $"HBox/MarginContainer_Upgrade3/Button"
	
	upgrade1.set_meta("Data", upgradeArray[upgradeChoices[0]])
	upgrade2.set_meta("Data", upgradeArray[upgradeChoices[1]])
	upgrade3.set_meta("Data", upgradeArray[upgradeChoices[2]])
	upgrade1.update()
	upgrade2.update()
	upgrade3.update()
