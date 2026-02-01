extends CharacterBody2D

@export var move_speed: float = 200
@export var jump_speed: float = 400
@export var gravity: float = 1200
@export var speed_mode_1 := 200
@export var speed_mode_2 := 200
@onready var sprite_a := $AnimatedSprite2D
@onready var sprite_b := $Modo2


var facing_right := true
var modo := 1
var speed := speed_mode_1

enum ESTADOS {IDLE,CORRER,SALTO}
var estadoActual = 0

#Collision layers
const LAYER_1 = 1 << 0
const LAYER_3 = 1 << 2
const LAYER_4 = 1 << 3


func _ready():
	sprite_b.visible = false  # empieza oculto
func _physics_process(delta: float) -> void:
	# Muerte
	var space_state = get_world_2d().direct_space_state

	var query = PhysicsPointQueryParameters2D.new()
	query.position = global_position
	query.collision_mask = 1 << 1  # layer 2
	query.collide_with_areas = true
	query.collide_with_bodies = true

	var result = space_state.intersect_point(query, 1)

	if result.size() > 0:
		print("TOCANDO LAVA" , global_position)
		morir()
	# --- Movimiento horizontal ---
	var input_axis := Input.get_axis("left", "right")
	velocity.x = input_axis * speed

	# --- Flip del personaje ---
	if input_axis != 0:
		estadoActual = ESTADOS.CORRER
		
		facing_right = input_axis > 0
		$Modo2.flip_h = not facing_right
		$AnimatedSprite2D.flip_h = not facing_right

	# --- Gravedad ---
	if not is_on_floor():
		velocity.y += gravity * delta
	

	# --- Salto ---
	if Input.is_action_just_pressed("jump") and is_on_floor():
	#	estadoActual = ESTADOS.SALTO
	#	spriteZ.play("saltar")
		velocity.y = -jump_speed
		
	update_animation(input_axis)

	move_and_slide()

func update_animation(input_axis):
	if not is_on_floor(): #if estadoActual == ESTADOS.SALTAR:
		sprite_a.play("saltar")
		sprite_b.play("saltar")
	elif input_axis != 0:
		sprite_a.play("correr")
		sprite_b.play("correr")
	else:
		sprite_a.play("idle")
		sprite_b.play("idle")
#--espera presionar/m

func _input(event):
	if event.is_action_pressed("cambiar_modo"):
		cambiar_modo()

			
func cambiar_modo():
	sprite_a.visible = not sprite_a.visible
	sprite_b.visible = not sprite_b.visible
	if modo == 1:
		modo = 2
		collision_mask &= ~LAYER_3
		collision_mask |= LAYER_4
		print(collision_layer)
		speed = speed_mode_2
		print("Modo 2 activado")
		
	else:
		modo = 1
		collision_mask &= ~LAYER_4
		collision_mask |= LAYER_3
		print(collision_layer)
		speed = speed_mode_1
		print("Modo 1 activado")
		
func morir():
	print("MUERTE POR LAVA")
	get_tree().reload_current_scene()
