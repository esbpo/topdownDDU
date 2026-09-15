extends Node

var won: bool = false # True if player has won the game
var currency: int = 0 # Currency for unlocking new characters
var unlocked_characters: Array = [0]

# Player texture filepath
var player_skin: String = "res://Assets/Textures/Player/PlayerModelHandgun.png"

var max_health = 750
var health = 750
var xp = 0
var time = 0
var wave = 1
var enemies_left = 0
var level = 0
var starter_weapon = 4 #id på starterweapon
var speed = 300
var totalXp = 0

var d:Dictionary = {}

func _extend(d1:Dictionary, d2:Dictionary):
	for key in d2.keys():
		d1[key] = d2[key]
	return d1

#Upgrade variabler
var damage_multiplier = 1 			#Damage multiplier, adds 0.2 or 20% per level on the multiplier
var base_health = 0 				#Additional base health. adds 100 base health pr level of upgrade
var health_multiplier = 1 			#Health multiplier, adds 0.25 or 25% per level to multiplier
var attack_speed_multiplier = 1		#Attack speed multiplier, adds 0.1 or 10% pr. level to multiplier
var movement_speed_multiplier = 1 	#Movement speed multiplier, adds 0.15 or 15% pr. upgrade level
var add_health_regen = 0 			#Health regen, add +5 health regen pr. level. max level = 3

# Data collection
var health_over_time = []
var enemies_killed_per_level = []
var upgrades = []

func WinGame():
	won = true
	get_tree().call_deferred("change_scene_to_file","res://scn_GameOverScreen.tscn")
	
func LoseGame():
	won = false
	get_tree().call_deferred("change_scene_to_file","res://scn_GameOverScreen.tscn")
