extends Button

func _pressed():
	print("creditos")
	get_tree().change_scene_to_file("res://scenes/MenuPrincipal/credit_menu.tscn")
