extends Button
@onready var StatMenu = $"/root/Node2D/scn_StatMenu"

func _pressed():
	StatMenu.ShowStatMenu()
	
