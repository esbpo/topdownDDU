extends Button
@onready var StatMenu = $"/root/Node2D/can_StatMenu"

func _pressed():
	StatMenu.ShowStatMenu()
	
