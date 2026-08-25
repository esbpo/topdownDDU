extends RigidBody2D

var shape: String = "square"
var sizeMult: float = 1
var speed: float = 50
@onready var player = $"../../obj_Player"
var radius: int = 20

func _ready() -> void:
	var collisionShape: CollisionShape2D = $"col_EnemyCollision"
	match shape:
		"square":
			collisionShape.shape = RectangleShape2D.new()
			collisionShape.scale = Vector2(sizeMult, sizeMult)

func _draw():
	match shape:
		"square":
			draw_rect(Rect2(-radius/2.0, -radius/2.0, radius * sizeMult, radius * sizeMult), Color.HOT_PINK, true)
	
func _integrate_forces(_state: PhysicsDirectBodyState2D) -> void:
	queue_redraw()
	
	var movement = (player.global_position - global_position).normalized() * speed
	linear_velocity = movement
	
	var angle = global_position.angle_to_point(player.global_position) + PI/2
	rotation = angle
