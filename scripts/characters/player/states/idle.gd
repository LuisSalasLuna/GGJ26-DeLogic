extends State


func enter() -> void:
	print("Enter idle")

func exit() -> void:
	print("Exit idle")

func process(_delta: float) -> void:
	if Input.get_axis("left", "right") != 0:
		request_transition.emit("Walk")
