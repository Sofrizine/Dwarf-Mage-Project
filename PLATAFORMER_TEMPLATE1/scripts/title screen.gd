extends Control





func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://scenes/level1.tscn")


func _on_load_game_pressed():
	pass # Replace with function body.


func _on_options_pressed():
	pass # Replace with function body.


func _on_exit_pressed():
	get_tree().quit()
