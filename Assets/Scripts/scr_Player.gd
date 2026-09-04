extends CharacterBody2D

@export var speed: float = 200

# Bullet scenes
@onready var baseBulletScene = preload("res://Assets/Resources/res_BaseBullet.tscn")
@onready var pierceBulletScene = preload("res://Assets/Resources/res_PierceBullet.tscn")
@onready var truePierceBulletScene = preload("res://Assets/Resources/res_TruePierceBullet.tscn")
@onready var spawnBulletScene = preload("res://Assets/Resources/res_SpawnBullet.tscn")

var target: RigidBody2D
var angle: float
var shootingInterval: float = 0
@export var firerate: float = 0.5 # Firerate in shots/second


# Movement start
func GetInput():
	var inputDirection = Input.get_vector("left", "right", "up", "down")
	velocity = inputDirection * speed
	
func _physics_process(_delta):
	GetInput()
	move_and_slide()
# Movement end


# Shooting system

func _process(delta: float) -> void:
	shootingInterval += delta
	
	# Shoot the target if one exists, otherwise point at cursor
	# Rewrite when weapons definitions are created
	if target:
		angle = global_position.angle_to_point(target.global_position) + PI/2
		rotation = angle
		if shootingInterval >= 1/firerate:
			
			# BaseBullet
			#_shoot(baseBulletScene, target, 800, 10, 10)
			
			# PierceBullet
			#_shoot(pierceBulletScene, target, 800, 100, 10)
			
			# TruePierceBullet
			#_shoot(truePierceBulletScene, target, 800, 1, 0.5, 40, 10)
			
			# SpawnBullet (Ball spawn)
			_shoot(spawnBulletScene, target, 600, 10, 0.5, 1, 2, truePierceBulletScene, {"damage": 40,"movement": Vector2(),"lifetime": 100,"width": 150,"height": 150,"texture": PlaceholderTexture2D.new(),})
			
			shootingInterval = 0
	else:
		var mouse_position = get_global_mouse_position()
		angle = global_position.angle_to_point(mouse_position) + PI/2
		rotation = angle

	target = SelectNewTarget()
	
func _shoot(bulletScene: PackedScene, bulletTarget: PhysicsBody2D, bulletSpeed: float, 
			damage: float, lifetime: float, width: float, height: float, spawn: PackedScene=null, spawn_data: Dictionary={}):
	var bulletInstance: RigidBody2D = bulletScene.instantiate()
	var bulletVector: Vector2 = (bulletTarget.global_position - global_position).normalized() * bulletSpeed
	var bulletData: Dictionary = {
		"damage": damage,
		"movement": bulletVector,
		"lifetime": lifetime,
		"width": width,
		"height": height,
		"texture": PlaceholderTexture2D.new(),
		"spawn": spawn,
		"spawn_data": spawn_data
	}
	
	$"..".add_child(bulletInstance)
	bulletInstance.rotation = angle
	bulletInstance.linear_velocity = bulletVector
	bulletInstance.data = bulletData
	bulletInstance.LoadSelf()
	
	var collisionShape = $col_PlayerCollider
	var playerGunPosition = Vector2((collisionShape.shape.radius+15)*cos(angle - PI/2),(collisionShape.shape.radius+15)*sin(angle - PI/2))
	bulletInstance.global_position = global_position + playerGunPosition
	bulletInstance.move_local_x(-width/2)
	bulletInstance.move_local_y(-height)

# Function to select new target
func SelectNewTarget() -> RigidBody2D:
	var collisions: Array = $area_PlayerMaxRange.get_overlapping_bodies()
	var bestDistance = INF
	var distance
	var new_target = null
	
	# Removes player from targets list
	collisions.erase(self)
	
	# Iterates over targets to get closest enemy
	for body: RigidBody2D in collisions:
		# Ensure no bullets are targeted
		if body.has_meta("bullet"):
			continue
			
		distance = global_position.distance_squared_to(body.global_position)
		
		if distance < bestDistance:
			bestDistance = distance
			new_target = body
			
	# Return best target
	return new_target

# Unnescessary with runtime targeting
#func _on_area_player_max_range_body_entered(body: Node2D) -> void:
	#if body.is_class("RigidBody2D") && !target:
		#target = body
#
#func _on_area_player_max_range_body_exited(body: Node2D) -> void:
	#if body == target:
		#target = SelectNewTarget()
