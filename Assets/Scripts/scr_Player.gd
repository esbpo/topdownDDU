extends CharacterBody2D

@export var speed: float = 200

var target: RigidBody2D
@onready var baseBulletScene = preload("res://Assets/Resources/res_BaseBullet.tscn")
var angle: float
var shootingInterval: float = 0
@export var firerate: float = 50 # Firerate in shots/second

func GetInput():
	var inputDirection = Input.get_vector("left", "right", "up", "down")
	velocity = inputDirection * speed
	
func _physics_process(_delta):
	GetInput()
	move_and_slide()

# Shooting system

func _process(delta: float) -> void:
	shootingInterval += delta
	
	# Shoot the target if one exists, otherwise point at cursor
	# Rewrite when weapons definitions are created
	if target:
		angle = global_position.angle_to_point(target.global_position) + PI/2
		rotation = angle
		if shootingInterval >= 1/firerate:
			_shoot(baseBulletScene, (target.global_position - global_position).normalized() * 800)
			shootingInterval = 0
	else:
		var mouse_position = get_global_mouse_position()
		angle = global_position.angle_to_point(mouse_position) + PI/2
		rotation = angle

	target = SelectNewTarget()
	
func _shoot(bulletScene: PackedScene, bulletVelocity: Vector2):
	var bulletInstance: RigidBody2D = bulletScene.instantiate()
	$"..".add_child(bulletInstance)
	bulletInstance.rotation = angle
	bulletInstance.linear_velocity = bulletVelocity
	
	var collisionShape = $col_PlayerCollider
	var playerGunPosition = Vector2((collisionShape.shape.radius+15)*cos(angle - PI/2),(collisionShape.shape.radius+15)*sin(angle - PI/2))
	bulletInstance.global_position = global_position + playerGunPosition

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
