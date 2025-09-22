extends Area2D

#@onready var game_manager = %GameManager
#@onready var timer = $Timer




#func _on_body_entered(body):
	#if body.name == ("player"):
		#var y_delta = position.y - body.position.y
		#var x_delta = body.position.x - position.x
		#if (x_delta > 0):
			#body.jump_side(500)
		#else:
			#body.jump_side(-500)
		
		


#func _on_area_entered(area: Area2D) -> void:
	#if area.name == "hurtbox":
		#print("decrease player health")
		#game_manager.decrease_health()
