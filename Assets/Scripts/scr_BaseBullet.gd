extends RigidBody2D

var time = 10
@export var damage: float = 10

func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 1
	set_meta("bullet", true)

func _process(delta: float) -> void:
	time -= delta
	
	if time <= 0:
		queue_free()

func _on_body_entered(body: Node) -> void:
	if body.health:
		body.health -= damage
	queue_free()
