extends Node2D

@onready var enemyScene: PackedScene = preload("res://scn_EnemyObj.tscn")
@onready var enemyJson: String = FileAccess.get_file_as_string("res://Data/EnemyDefinitions.json")
var enemyArray: Array

func _ready() -> void:
	enemyArray = JSON.parse_string(enemyJson)
	SpawnWave()

func SpawnGroup(enemyId: int, enemyCount: int):
	var enemyData: Dictionary = enemyArray[enemyId]
	for i in range(enemyCount * enemyData["spawn_multiplier"]):
		var enemyInstance: RigidBody2D = enemyScene.instantiate()
		
		enemyInstance.speed = enemyData["speed"]
		enemyInstance.shape = enemyData["shape"]
		enemyInstance.sizeMult = enemyData["size_multiplier"]
		
		add_child(enemyInstance)
		
		enemyInstance.global_position = Vector2(randi_range(-1000, 1000), randi_range(-1000, 1000))
		enemyInstance.contact_monitor = true
		
		while !(enemyInstance.get_colliding_bodies().is_empty()):
			enemyInstance.global_position = Vector2(randi_range(-1000, 1000), randi_range(-1000, 1000))

func SpawnWave():
	SpawnGroup(1, 25)
	SpawnGroup(0, 25)
