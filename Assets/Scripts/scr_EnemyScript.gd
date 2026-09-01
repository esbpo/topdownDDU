extends RigidBody2D

var shape: String
var sizeMult: float
var speed: float
@onready var player = $"../../obj_Player"
var radius: int = 20
var health: float
var damage: float

var exp: float = 0

func _ready() -> void:
	var collisionShape: CollisionShape2D = $col_EnemyCollision
	contact_monitor = true
	max_contacts_reported = 10
	
	# Exp gained on kill
	exp = health
	
	match shape:
		"square":
			var form: RectangleShape2D = RectangleShape2D.new()
			form.size = Vector2(sizeMult * radius, sizeMult * radius)
			collisionShape.shape = form
		"circle":
			var form: CircleShape2D = CircleShape2D.new()
			form.radius = radius * sizeMult
			collisionShape.shape = form	
		"arrow":
			var form: ConvexPolygonShape2D = load("res://Assets/Resources/res_TriangleCollider.tres")
			collisionShape.shape = form
			collisionShape.scale = Vector2(sizeMult, sizeMult)

func _draw():
	match shape:
		"square":
			draw_rect(Rect2(-radius/2.0, -radius/2.0, radius * sizeMult, radius * sizeMult), Color.HOT_PINK, false)
			draw_rect(Rect2(-radius/2.0+1, -radius/2.0+1, (radius-2) * sizeMult, (radius-2) * sizeMult), Color.HOT_PINK, false)
		"circle":
			draw_circle(Vector2(0, 0), radius * sizeMult, Color.RED, false)
			draw_circle(Vector2(0, 0), (radius-1) * sizeMult, Color.RED, false)
		"arrow":
			draw_polyline([Vector2(0,(radius/2.) * sizeMult),Vector2((radius / 4.) * sizeMult,0),Vector2((radius/2.) * sizeMult, (radius/2.) * sizeMult)], Color.AQUA, 2)
			
	
func _integrate_forces(_state: PhysicsDirectBodyState2D) -> void:
	queue_redraw()
	
	var movement = (player.global_position - global_position).normalized() * speed
	linear_velocity = movement
	
	var angle = global_position.angle_to_point(player.global_position) + PI/2
	rotation = angle

func _process(_delta: float) -> void:
	if health <= 0:
		Globals.enemies_left -= 1
		Globals.xp += exp
		queue_free()

func _on_body_entered(body: Node) -> void:
	if body == $"/root/Node2D/obj_Player":
		Globals.health -= damage
