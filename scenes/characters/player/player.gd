extends CharacterBody2D

@export var move_speed: float = 200
@export var jump_speed: float = 400
@export var gravity: float = 1200
@export var speed_mode_1 := 50
@export var speed_mode_2 := 400

var facing_right := true
var modo := 1
var speed := speed_mode_1

func _physics_process(delta: float) -> void:
	# --- Movimiento horizontal ---
	var input_axis := Input.get_axis("left", "right")
	velocity.x = input_axis * speed

	# --- Flip del personaje ---
	if input_axis != 0:
		facing_right = input_axis > 0
		$Sprite2D.flip_h = not facing_right

	# --- Gravedad ---
	if not is_on_floor():
		velocity.y += gravity * delta

	# --- Salto ---
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_speed

	move_and_slide()
	
func _input(event):
	if event.is_action_pressed("cambiar_modo"):
		cambiar_modo()
		
func cambiar_modo():
	if modo == 1:
		modo = 2
		speed = speed_mode_2
		print("Modo 2 activado")
	else:
		modo = 1
		speed = speed_mode_1
		print("Modo 1 activado")
