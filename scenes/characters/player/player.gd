extends CharacterBody2D

@export var move_speed:float
@export var jump_speed:float
var facing_right = true
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(_delta: float) -> void:
	var input_axis = Input.get_axis("left","right")
	velocity.x = input_axis * move_speed
	
	if Input.is_action_just_pressed("jump"):
		velocity.y = -jump_speed
	velocity.y += gravity * _delta
	
	if (facing_right and velocity.x<0) or (not facing_right and velocity.x>0):
		print(velocity.x)
		scale.x *= -1
		facing_right = not facing_right
	move_and_slide()
