extends StaticBody2D
@onready var anim = $anim
@onready var timer = $Timer
@onready var breakbox = $breakbox/breakbox
@onready var collision_shape_2d = $CollisionShape2D
@onready var sound_fx = $soundFX

#prop1


func _on_breakbox_area_entered(area):
	if area.name == "hitbox":
		print("broke")
		breakbox.set_deferred("disabled", true)
		collision_shape_2d.set_deferred("disabled", true)
		anim.play("breaking")
		sound_fx.play()
		timer.start()


func _on_timer_timeout():
	anim.play("broken")
	



	pass # Replace with function body.
