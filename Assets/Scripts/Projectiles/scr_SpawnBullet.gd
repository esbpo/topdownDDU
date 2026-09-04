extends RigidBody2D

var data: Dictionary
var lifetime: float = 10
var damage: float = 10
var movement: Vector2 = Vector2()
var texture = PlaceholderTexture2D.new()
var width: int = 1
var height: int = 1
var spawn: PackedScene
var spawn_data: Dictionary

func LoadSelf() -> void:
	
	lifetime = data["lifetime"]
	damage = data["damage"]
	movement = data["movement"]
	texture = data["texture"] if "texture" in data.keys() else texture
	width = data["width"]
	height = data["height"]
	spawn = data["spawn"]
	spawn_data = data["spawn_data"]
	
	contact_monitor = true
	max_contacts_reported = 1
	set_meta("bullet", true)
	
	$col_Bullet.scale = Vector2(width, height) / 2
	$spr_Bullet.scale = Vector2(width, height)
	$spr_Bullet.position = Vector2(-width/2., -height/2.)

func _process(delta: float) -> void:
	lifetime -= delta
	
	if lifetime <= 0:
		SpawnSubBullet()
		queue_free()

func _integrate_forces(_state: PhysicsDirectBodyState2D) -> void:
	linear_velocity = movement

func _on_body_entered(body: Node) -> void:
	if "health" in body:
		body.health -= damage
		SpawnSubBullet()
		queue_free()
		
func SpawnSubBullet():
	var subBullet = spawn.instantiate()
	$"..".add_child(subBullet)
	subBullet.global_position = global_position
	subBullet.data = spawn_data
	subBullet.LoadSelf()
