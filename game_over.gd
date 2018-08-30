extends Panel

func _on_quit_pressed():
	get_tree().quit()


func _on_continue_pressed():
	get_tree().change_scene("res://town.tscn")
