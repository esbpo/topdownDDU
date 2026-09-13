extends CharacterBody2D

@export var speed: float = 200

# Bullet scenes
#defined as "type": "basic" in Weapons.json
@onready var baseBulletScene = preload("res://Assets/Resources/Bullets/res_BaseBullet.tscn")
#defined as "type": "pierce" in Weapons.json
@onready var pierceBulletScene = preload("res://Assets/Resources/Bullets/res_PierceBullet.tscn")
#defined as "type": "truePierce" in Weapons.json
@onready var truePierceBulletScene = preload("res://Assets/Resources/Bullets/res_TruePierceBullet.tscn")
#defined as "type": "spawn" in Weapons.json
@onready var spawnBulletScene = preload("res://Assets/Resources/Bullets/res_SpawnBullet.tscn")

@onready var weaponJson: String = FileAccess.get_file_as_string("res://Data/Weapons.json")
var weaponArray: Array = []

var target: RigidBody2D
var angle: float

var shootingIntervals: Array = []
var firerates: Array = [] # Firerate in shots/second
var weapons: Array = [] # Equipped weapons

func _ready() -> void:
	weaponArray = JSON.parse_string(weaponJson)
	Equip(3)
#In Weapons.json the following id's refer to specified weapon
#id - 0 = starter pistol
#id - 1 = assault rifle
#id - 2 = sniper rifle
#id - 3 = shotgun
#id - 4 = laser
#id - 5 = flamethrower
func GetInput():
	var inputDirection = Input.get_vector("left", "right", "up", "down")
	velocity = inputDirection * speed * Globals.movement_speed_multiplier
	
func _process(delta: float) -> void:
	GetInput()
	move_and_slide()

	# Regenerate lost health
	if Globals.health < Globals.max_health:
		Globals.health += Globals.add_health_regen * delta

	# Shooting system
	var i = 0
	for interval in shootingIntervals:
		shootingIntervals[i] += delta
	
		# Shoot the target if one exists, otherwise point at cursor
		if target:
			angle = global_position.angle_to_point(target.global_position) + PI/2
			rotation = angle
		
			if interval >= 1 / (firerates[i] * Globals.attack_speed_multiplier):
				var weapon = weapons[i]
				var damage = weapon["damage"] * Globals.damage_multiplier
				# Shoot the weapon
				_shoot(weapon["type"], target, weapon["bulletspeed"], damage, weapon["lifetime"], weapon["width"], weapon["height"], weapon["bulletamount"], weapon["bulletspread"])
				shootingIntervals[i] = 0
		else:
			var mouse_position = get_global_mouse_position()
			angle = global_position.angle_to_point(mouse_position) + PI/2
			rotation = angle
		i += 1
	target = SelectNewTarget()
	
func _shoot(bulletScene: PackedScene, bulletTarget: PhysicsBody2D, bulletSpeed: float, 
			damage: float, lifetime: float, width: float, height: float, bulletAmount: int, bulletSpread: float, 
			spawn: PackedScene=null, spawn_data: Dictionary={}):
	
	var bulletData: Dictionary = {
		"damage": damage,
		"lifetime": lifetime,
		"width": width,
		"height": height,
		"texture": load("res://Assets/Resources/UI/res_BaseBulletTexture.tres"),
		"spawn": spawn,
		"spawn_data": spawn_data,
	}
	for j in range(bulletAmount):
		var bulletInstance: RigidBody2D = bulletScene.instantiate()
		var bulletAngle: float = global_position.angle_to_point(bulletTarget.global_position)
		bulletAngle += randf_range(-bulletSpread, bulletSpread)
		
		var bulletVector: Vector2 = Vector2(cos(bulletAngle), sin(bulletAngle)) * bulletSpeed
		
		bulletData["movement"] = bulletVector
	
		$"..".add_child(bulletInstance)
		bulletInstance.rotation = angle
		bulletInstance.linear_velocity = bulletVector
		bulletInstance.data = bulletData
		bulletInstance.LoadSelf()
		
		var collisionShape = $col_PlayerCollider
		var playerGunPosition = Vector2((collisionShape.shape.radius+15)*cos(angle - PI/2),(collisionShape.shape.radius+15)*sin(angle - PI/2))
		bulletInstance.global_position = global_position + playerGunPosition
		bulletInstance.move_local_x(-width/2)
		bulletInstance.move_local_y(-height/2)

# Function to select new target
func SelectNewTarget() -> RigidBody2D:
	var collisions: Array = $area_PlayerMaxRange.get_overlapping_bodies()
	var bestDistance = INF
	var distance
	var new_target = null
	
	# Removes player from targets list
	collisions.erase(self)
	
	# Iterates over targets to get closest enemy
	for body in collisions:
		# Ensure only enemies are targeted
		if not "health" in body: continue
			
		distance = global_position.distance_squared_to(body.global_position)
		
		if distance < bestDistance:
			bestDistance = distance
			new_target = body
			
	# Return best target
	return new_target

func Equip(id):
	var weapon = weaponArray[int(id)]
	firerates.append(weapon["firerate"])
	shootingIntervals.append(0)
	weapons.append(weapon)
	
	match weapon["type"]:
		"basic": 
			weapon["type"] = baseBulletScene 
		"pierce":
			weapon["type"] = pierceBulletScene
		"truePierce":
			weapon["type"] = truePierceBulletScene

#Basic bullet is used for following: Starter pistol, Assault rifle, Shotgun, 
#Pierce bullet is used for following: Sniper,
#True pierce bullet is used for following: Laser,



# Unnescessary with runtime targeting
#func _on_area_player_max_range_body_entered(body: Node2D) -> void:
	#if body.is_class("RigidBody2D") && !target:
		#target = body
#
#func _on_area_player_max_range_body_exited(body: Node2D) -> void:
	#if body == target:
		#target = SelectNewTarget()
