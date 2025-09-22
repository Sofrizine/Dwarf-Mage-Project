extends StaticBody2D
@onready var anim = $anim
@onready var timer = $Timer
@onready var breakbox = $breakbox/breakbox
@onready var collision_shape_2d = $CollisionShape2D
@onready var sound_fx = $soundFX
@onready var game_manager: Node = %GameManager

#prop2
@onready var heart_sprite: Sprite2D = $Heart/HeartSprite
@onready var heart_collision: CollisionShape2D = $Heart/HeartCollision
var heart = false

func _on_breakbox_area_entered(area):
	if area.name == "hitbox":
		print("broke")
		breakbox.set_deferred("disabled", true)
		collision_shape_2d.set_deferred("disabled", true)
		anim.play("breaking")
		sound_fx.play()
		heart = true
		heart_sprite.set_deferred("visible", true)
		heart_collision.set_deferred("disabled", false)
		timer.start()

func _on_timer_timeout():
	anim.play("broken")
	
func _on_heart_area_entered(area):
		if area.name == "hurtbox" and heart == true:
			game_manager.increase_health()
			heart_sprite.set_deferred("visible", false)
			heart_collision.set_deferred("disabled", true)
			print("heart")
			heart = false
	
	
