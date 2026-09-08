extends Control
@onready var parent = $".."
	
func Upgrade():
	var upgradeChoices = [randi_range(0, len(parent.upgradeArray)-1), randi_range(0, len(parent.upgradeArray)-1), randi_range(0, len(parent.upgradeArray)-1),]
	if parent.upgradesAvailable >= 3: #As long as there are 3 or more upgrades not at max level, make all 3 upgrades different.
		#otherwise allow upgradechoices to be the same
		while upgradeChoices[0] == upgradeChoices[1] or upgradeChoices[0] == upgradeChoices[2]:
			upgradeChoices[0] = randi_range(1, len(parent.upgradeArray)-1)
		while upgradeChoices[1] == upgradeChoices[0] or upgradeChoices[1] == upgradeChoices[2]:
			upgradeChoices[1] = randi_range(1, len(parent.upgradeArray)-1)
	
	
	var upgrade1 = $"HBox/MarginContainer_Upgrade1/Button"
	var upgrade2 = $"HBox/MarginContainer_Upgrade2/Button"
	var upgrade3 = $"HBox/MarginContainer_Upgrade3/Button"
	
	upgrade1.set_meta("Data", parent.upgradeArray[upgradeChoices[0]])
	upgrade2.set_meta("Data", parent.upgradeArray[upgradeChoices[1]])
	upgrade3.set_meta("Data", parent.upgradeArray[upgradeChoices[2]])
	upgrade1.update()
	upgrade2.update()
	upgrade3.update()
	
func levelIncrease (id):
	parent.upgradeArray[id]["level"] += 1
	if parent.upgradeArray[id]["level"] == parent.upgradeArray[id]["maxlevel"]:
		parent.upgradesAvailable -= 1
