extends HSlider
@onready var LevelUp = $"/root/Node2D/can_LevelUp"

func GetXpCost(level):
	return 107.96 * pow(1.33, level) - 43.62

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	value = Globals.xp

	if value >= max_value:
		value -= max_value
		Globals.xp -= max_value
		Globals.level += 1
		max_value = GetXpCost(Globals.level)
		max_value = round(max_value)
		LevelUp.ShowUpgrades()
		
		
