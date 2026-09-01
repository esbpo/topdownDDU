extends Node2D

# Enemy scene and json references
@onready var enemyScene: PackedScene = preload("res://Assets/Resources/res_EnemyObj.tscn")
@onready var enemyJson: String = FileAccess.get_file_as_string("res://Data/EnemyDefinitions.json")

var enemyArray: Array

# Hardcoded waves, replace later
var waves = [
	[[0, 25]],
	[[0,25],[1,10]],
	[[2,50],[1,25]],
	[[2,50],[1,50]],
	[[2,75],[1,50]],
	[[2,100],[1,50]],
	[[2,50],[1,200]]
]

# Helper variables
var waveCount = 0
var enemiesMax = 0
var cnt: float = 0

# Gets a count of enemies in wave
func GetEnemiesMax(waveNumber):
	var arr = waves[waveNumber]
	var count = 0
	
	for i in range(len(arr)):
		var spawnMult = enemyArray[arr[i][0]]["spawn_multiplier"]
		count += arr[i][1] * spawnMult
		
	return count

func _ready() -> void:
	enemyArray = JSON.parse_string(enemyJson)
	
	# Spawn first wave
	SpawnWave(waveCount)
	enemiesMax = GetEnemiesMax(waveCount)
	Globals.enemies_left += enemiesMax
	waveCount += 1

# Function to spawn a group of enemies
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

# Function to spawn a wave of enemies
func SpawnWave(waveNumber):
	var wave = waves[waveNumber]
	for i in range(len(wave)):
		SpawnGroup(wave[i][0], wave[i][1])

func _process(delta: float) -> void:
	cnt += delta
	
	# If half of enemies have been killed, spawn next wave
	if Globals.enemies_left < round(enemiesMax / 2.0):
		SpawnWave(waveCount)
		enemiesMax = GetEnemiesMax(waveCount)
		Globals.enemies_left += enemiesMax
		if waveCount < len(waves) - 1:
			waveCount += 1
	
	
