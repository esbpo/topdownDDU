extends Button

@onready var canvas: CanvasLayer = $"/root/Node2D/can_PauseMenu"

func _pressed() -> void:
	canvas.visible = true
	get_tree().paused = true
