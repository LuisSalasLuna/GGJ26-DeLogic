extends Button

func _pressed():
	print("jugar")
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")
