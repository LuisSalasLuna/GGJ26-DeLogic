extends State

func enter() -> void:
	print("Attacking")
	await get_tree().create_timer(3).timeout
	request_transition.emit("Idle")

func exit() -> void:
	print("End Attack")

func process(_delta: float) -> void:
	pass

func physics_process(_delta: float) -> void:
	pass
