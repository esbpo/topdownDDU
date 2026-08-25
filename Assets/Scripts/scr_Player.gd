extends CharacterBody2D

@export var speed: float = 200


func GetInput():
	var inputDirection = Input.get_vector("left", "right", "up", "down")
	velocity = inputDirection * speed
	
func _physics_process(delta):
	GetInput()
	move_and_slide()
	
