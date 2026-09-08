extends HSlider
@onready var LevelUp = $"/root/Node2D/can_LevelUp"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	value = Globals.xp

	if value >= max_value:
		value -= max_value
		Globals.xp -= max_value
		max_value *= 1.2
		max_value = round(max_value)
		LevelUp.ShowUpgrades()
		
		
