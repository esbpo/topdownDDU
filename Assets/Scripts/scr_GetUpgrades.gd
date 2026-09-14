extends Control
@onready var parent = $".."
@onready var whatDict 	#this is to shorten the code so we don't need
										#to have practically the same code two times
func Upgrade():
	var upgrade1 = $"HBox/MarginContainer_Upgrade1/Button"
	var upgrade2 = $"HBox/MarginContainer_Upgrade2/Button"
	var upgrade3 = $"HBox/MarginContainer_Upgrade3/Button"
	if Globals.level % 5 == 0:
		whatDict = parent.weaponUnlockDict
	else:
		whatDict = parent.upgradeDict
	var upgradeChoices = [whatDict.keys().pick_random(),whatDict.keys().pick_random(),whatDict.keys().pick_random()]
	if len(whatDict) >= 3: #As long as there are 3 or more upgrades not at max level, make all 3 upgrades different.
		#otherwise allow upgradechoices to be the same
		#While two of the upgradechoices are the same, choose a new upgrade from that dict
		while (upgradeChoices[0] == upgradeChoices[1] or upgradeChoices[0] == upgradeChoices[2]):
			upgradeChoices[0] = whatDict.keys().pick_random()
		while (upgradeChoices[1] == upgradeChoices[0] or upgradeChoices[1] == upgradeChoices[2]):
			upgradeChoices[1] = whatDict.keys().pick_random()
		
	upgrade1.set_meta("Data", whatDict[upgradeChoices[0]])
	upgrade2.set_meta("Data", whatDict[upgradeChoices[1]])
	upgrade3.set_meta("Data", whatDict[upgradeChoices[2]])
	upgrade1.update()
	upgrade2.update()
	upgrade3.update()
	
func levelIncrease (id):
	#Raises the chosen upgrades level by 1
	whatDict[id]["level"] += 1
	#Erases the upgrade from the upgrade dictionay if it has reached maxlevel. Thus the player cannot pick it again.
	if whatDict[id]["level"] >= whatDict[id]["maxlevel"]:
		whatDict.erase(id) 
