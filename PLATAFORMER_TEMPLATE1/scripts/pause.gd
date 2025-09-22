extends Node
@onready var pausepanel = %pausepanel



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var esc_pressed = Input.is_action_just_pressed("pause")
	if (esc_pressed == true):
		get_tree().paused = true
		pausepanel.show()
		
		
func _on_resume_pressed():

	pausepanel.hide()
	get_tree().paused = false
	

func _on_exit_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
