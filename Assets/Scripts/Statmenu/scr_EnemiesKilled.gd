extends Label
@export var shape: String

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	text = str(int(Globals.enemies_killed[shape]))
