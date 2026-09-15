extends Label
@onready var xpNextLevel = $"/root/Node2D/obj_Player/cam_PlayerCamera/Ui/Ui/MarginContainer_hp_xp-Bars/VBoxContainer/Slider_xpBar"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	text = "XP to next level:" + str(int(Globals.xp)) + "/" + str(int(xpNextLevel.max_value))
