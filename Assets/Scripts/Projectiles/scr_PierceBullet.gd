extends RigidBody2D

var data: Dictionary
var lifetime: float = 10
var damage: float = 10
var movement: Vector2 = Vector2()
var texture = PlaceholderTexture2D.new()
var width: int = 1
var height: int = 1

func LoadSelf() -> void:
	
	lifetime = data["lifetime"]
	damage = data["damage"]
	movement = data["movement"]
	texture = data["texture"] if "texture" in data.keys() else texture
	width = data["width"]
	height = data["height"]
	
	contact_monitor = true
	max_contacts_reported = 1
	set_meta("bullet", true)
	
	$col_Bullet.scale = Vector2(width, height) / 2
	$spr_Bullet.scale = Vector2(width, height)
	$spr_Bullet.position = Vector2(-width/2., -height/2.)

func _process(delta: float) -> void:
	lifetime -= delta
	
	if lifetime <= 0:
		queue_free()

func _integrate_forces(_state: PhysicsDirectBodyState2D) -> void:
	linear_velocity = movement

func _on_body_entered(body: Node) -> void:
	if "health" in body:
		var bodyHealth = body.health
		body.health -= damage
		damage -= bodyHealth

	if damage <= 0:
		queue_free()
