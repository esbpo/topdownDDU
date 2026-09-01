extends Node2D

@onready var enemyScene: PackedScene = preload("res://Assets/Resources/res_EnemyObj.tscn")
@onready var enemyJson: String = FileAccess.get_file_as_string("res://Data/EnemyDefinitions.json")
var enemyArray: Array
var cnt: float = 0
var waves = [
	[[0, 25]],
	[[0,25],[1,10]],
	[[2,50],[1,25]],
	[[2,50],[1,50]],
	[[2,75],[1,50]],
	[[2,100],[1,50]],
	[[2,50],[1,200]]
]

var waveCount = 0
var enemiesMax = 0

func GetEnemiesMax(waveNumber):
	var arr = waves[waveNumber]
	var count = 0
	for i in range(len(arr)):
		count += arr[i][1]
	return count

func _ready() -> void:
	enemyArray = JSON.parse_string(enemyJson)
	SpawnWave(waveCount)
	enemiesMax = GetEnemiesMax(waveCount)
	waveCount += 1

func SpawnGroup(enemyId: int, enemyCount: int):
	var enemyData: Dictionary = enemyArray[enemyId]
	for i in range(enemyCount * enemyData["spawn_multiplier"]):
		var enemyInstance: RigidBody2D = enemyScene.instantiate()
		
		enemyInstance.speed = enemyData["speed"]
		enemyInstance.shape = enemyData["shape"]
		enemyInstance.sizeMult = enemyData["size_multiplier"]
		enemyInstance.health = enemyData["health"]
		enemyInstance.damage = enemyData["damage"]
		
		add_child(enemyInstance)
		
		enemyInstance.global_position = Vector2(randi_range(-1000, 1000), randi_range(-1000, 1000))
		enemyInstance.contact_monitor = true
		
		while !(enemyInstance.get_colliding_bodies().is_empty()):
			enemyInstance.global_position = Vector2(randi_range(-1000, 1000), randi_range(-1000, 1000))

func _process(delta: float) -> void:
	cnt += delta
	if Globals.enemies_left < round(enemiesMax / 2.0):
		SpawnWave(waveCount)
		enemiesMax = GetEnemiesMax(waveCount)
		Globals.enemies_left += enemiesMax
		if waveCount < len(waves) - 1:
			waveCount += 1

func SpawnWave(waveNumber):
	var wave = waves[waveNumber]
	for i in range(len(wave)):
		SpawnGroup(wave[i][0], wave[i][1])
	
	
