extends Node
class_name EnemyCreator

var enemyArray: Array

func _ready() -> void:
	var json = load("res://Data/EnemyDefinitions.json")
	enemyArray = JSON.parse_string(json)

func _CreateEnemy(index):
	
	pass

func GetRandomSpawn(enemyMultiplier):
	var lenght = len(enemyArray)
	_CreateEnemy(randi_range(0, lenght))
	pass
	
func GetSpecificSpawn(enemyID):
	pass
