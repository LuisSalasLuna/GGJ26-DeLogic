extends State

func enter() -> void:
	pass

func exit() -> void:
	pass

func process(_delta: float) -> void:
	if Input.is_action_just_pressed("toggle_mask"):
		request_transition.emit("Mask")

func physics_process(_delta: float) -> void:
	pass
