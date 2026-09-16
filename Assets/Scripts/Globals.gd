extends Node

var won: bool = false # True if player has won the game
var currency: int = 0 # Currency for unlocking new characters
var unlocked_characters: Array = [0]

# Player texture filepath
var player_skin: String = "res://Assets/Textures/Player/PlayerModelHandgun.png"

var max_health: int = 750
var health: int = 750
var xp: int = 0
var time: float = 0
var wave: int = 1
var enemies_left: int = 0
var level: int = 0
var starter_weapon: int = 0 # 0 = Id på starterweapon
var speed: int = 300

#Stat menu variables
var totalXp: int = 0
var enemies_killed: Dictionary = {"square":0, "circle":0, "triangle":0}

#Upgrade variables
var damage_multiplier: float = 1 			# Damage multiplier, adds 0.2 or 20% per level on the multiplier
var base_health: int = 0 					# Additional base health. adds 100 base health pr level of upgrade
var health_multiplier: float = 1 			# Health multiplier, adds 0.25 or 25% per level to multiplier
var attack_speed_multiplier: float = 1		# Attack speed multiplier, adds 0.1 or 10% pr. level to multiplier
var movement_speed_multiplier: float = 1 	# Movement speed multiplier, adds 0.15 or 15% pr. upgrade level
var add_health_regen: int = 0 				# Health regen, add +5 health regen pr. level. max level = 3

# Data collection
var health_over_time: Array = []
var enemies_killed_per_level: Array = []
var upgrades: Array = []
var level_gained: bool = false
var intermittent_enemies_killed: int = 0
var upgrades_over_time: Array = []

func WinGame():
	won = true
	get_tree().call_deferred("change_scene_to_file","res://scn_GameOverScreen.tscn")
	
func LoseGame():
	won = false
	get_tree().call_deferred("change_scene_to_file","res://scn_GameOverScreen.tscn")
