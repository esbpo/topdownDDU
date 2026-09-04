extends Node

var health = 1000
var xp = 0
var time = 0
var wave = 1
var enemies_left = 0

#Upgrade variabler
var damage_multiplier = 1 #Damage multiplier, adds 0.2 or 20% per level on the multiplier
var add_base_health = 100 #Additional base health. adds 100 base health pr level of upgrade
var health_multiplier = 1 #Health multiplier, adds 0.25 or 25% per level to multiplier
var attack_speed_multiplier = 1 #Attack speed multiplier, adds 0.1 or 10% pr. level to multiplier
var movement_speed_multiplier = 1 #Movement speed multiplier, adds 0.15 or 15% pr. upgrade level
var add_health_regen = 0 #Health regen, add +5 health regen pr. level. max level = 3
