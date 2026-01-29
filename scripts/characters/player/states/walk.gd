extends State

const SPEED: float = 200
const JUMP_VELOCITY: float = 2000

func enter() -> void:
	print("Enter walk")

func exit() -> void:
	print("Exit walk")


func body_move(_delta: float) -> bool:
		
	var direction : float = Input.get_axis("left", "right")
	
	if direction:
		owner_node.velocity.x = direction * SPEED
	else:
		owner_node.velocity.x = move_toward(owner_node.velocity.x, 0, SPEED)

	if direction != 0 :
		return true
	else:
		return false
			
func physics_process(delta: float) -> void:
	if not body_move(delta):
		request_transition.emit("Idle")
	owner_node.move_and_slide()
	
