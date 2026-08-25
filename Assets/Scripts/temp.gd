extends Node2D


func _ready() -> void:
	for i in range(50):
		var copy: RigidBody2D = $"obj_Enemy".duplicate()
		add_child(copy)
		copy.global_position = Vector2(randi_range(-1000, 1000), randi_range(-1000, 1000))
		copy.contact_monitor = true
		while !(copy.get_colliding_bodies().is_empty()):
			copy.global_position = Vector2(randi_range(-1000, 1000), randi_range(-1000, 1000))
