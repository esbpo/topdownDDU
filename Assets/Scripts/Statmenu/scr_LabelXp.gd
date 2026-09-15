extends Label
@onready var xpNextLevel = $"/root/Node2D/obj_Player/cam_PlayerCamera/Ui/Ui/MarginContainer_hp_xp-Bars/VBoxContainer/Slider_xpBar"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = "XP to next level:" + str(int(Globals.xp)) + "/" + str(int(xpNextLevel.max_value))
