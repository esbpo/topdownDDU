extends Button

func _pressed() -> void:
	get_tree().change_scene_to_file("res://scn_gamplay.tscn")
