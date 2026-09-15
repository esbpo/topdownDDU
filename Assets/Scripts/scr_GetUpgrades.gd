extends Control
@onready var parent = $".."
@onready var whatDict 		# This is to shorten the code so we don't need
@onready var otherDict		# To have practically the same code two times
# whatDict refers to the dict that the player is supposed to get upgrades from
# that being upgradeDict unless player i level 5,10,15 etc..
# otherDict is there in case there aren't enough upgrades remaining in whatDict

func _extend(d1:Dictionary, d2:Dictionary):
	for key in d2.keys():
		d1[key] = d2[key]
	return d1 
	
func Upgrade():
	var upgrade1 = $"HBox/MarginContainer_Upgrade1/Button"
	var upgrade2 = $"HBox/MarginContainer_Upgrade2/Button"
	var upgrade3 = $"HBox/MarginContainer_Upgrade3/Button"
	if Globals.level % 5 == 0:
		whatDict = parent.weaponUnlockDict
		otherDict = parent.upgradeDict
	else:
		whatDict = parent.upgradeDict
		otherDict = parent.weaponUnlockDict
	var upgradeChoices = [whatDict.keys().pick_random(),whatDict.keys().pick_random(),whatDict.keys().pick_random()]
	if len(whatDict) >= 3: #As long as there are 3 or more upgrades not at max level, make all 3 upgrades different.
		#While two of the upgradechoices are the same, choose a new upgrade from that dict
		while (upgradeChoices[0] == upgradeChoices[1] or upgradeChoices[0] == upgradeChoices[2]):
			upgradeChoices[0] = whatDict.keys().pick_random()
		while (upgradeChoices[1] == upgradeChoices[0] or upgradeChoices[1] == upgradeChoices[2]):
			upgradeChoices[1] = whatDict.keys().pick_random()
		# Sets metadata to upgradechoices
		
		
	# If there are less than 3 upgrades available in whatDict, 
	# Check how many are left in whatDict
	else:
		whatDict = _extend(whatDict, otherDict)
		# If there are 2 upgrades left in whatDict, pull last upgrade from otherDict
		
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
