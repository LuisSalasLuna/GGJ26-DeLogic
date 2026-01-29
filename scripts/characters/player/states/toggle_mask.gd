extends State

func enter() -> void:
	print("Changing side")
	toggle_side()
	await get_tree().create_timer(1.5).timeout
	request_transition.emit("Idle")

func exit() -> void:
	print("Side changed")

func process(_delta: float) -> void:
	pass

func physics_process(_delta: float) -> void:
	pass

func toggle_side():
	
	owner_node.side_one.visible = !owner_node.side_one.visible 
	owner_node.side_two.visible = !owner_node.side_two.visible 
	
	owner_node.side_one.set_physics_process(owner_node.side_one.visible)
	owner_node.side_two.set_physics_process(!owner_node.side_two.visible)

	owner_node.collision_mask = 1 if owner_node.side_one.visible else 2
