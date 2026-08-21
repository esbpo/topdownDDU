extends Node2D

@export var shape: String
@export var sizeMult: float
var speed: float = 1
@onready var player = $"../../obj_Player"
var radius: int = 20

func _ready() -> void:
	var collisionShape: CollisionShape2D = $"CollisionShape2D"
	match shape:
		"square":
			collisionShape.shape = RectangleShape2D.new()
			collisionShape.scale = Vector2(sizeMult, sizeMult)

func _draw():
	match shape:
		"square":
			draw_rect(Rect2(position, Vector2(radius * sizeMult, radius * sizeMult)), Color.WHITE, false)
	
func _process(_delta: float) -> void:
	position.x = move_toward(position.x, player.position.x, speed)
	position.y = move_toward(position.y, player.position.y, speed)
	queue_redraw()
