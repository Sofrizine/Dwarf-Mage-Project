extends Area2D
@onready var death: AudioStreamPlayer2D = $"../GameManager/death"



func _on_body_entered(body):
	if body.name == ("player"):
		death.play()

func _on_death_finished():
	get_tree().reload_current_scene()
