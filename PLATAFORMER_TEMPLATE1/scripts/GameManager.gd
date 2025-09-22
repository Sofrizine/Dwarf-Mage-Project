extends Node


@onready var collision_shape_2d = $"../player/CollisionShape2D"
@export var lifebar : Array[Node]
@onready var timer = $Timer
@onready var player: CharacterBody2D = $"../player"
@onready var death: AudioStreamPlayer2D = $death
@onready var deathzone: Area2D = $"../deathzone"


var lives = 3


func decrease_health():
	print("decrease player health")
	lives -= 1
	print(lives)
	
	for h in 3:
		if (h < lives):
			lifebar[h].show()
		else:
			lifebar[h].hide()
	
	if (lives == 0):
		player.set_deferred("z_index", 3)
		collision_shape_2d.set_deferred("disabled", true)
		
		timer.start()
		
func increase_health():
	print("increase player health")
	lives += 1
	print(lives)
	for h in 3:
		if (h < lives):
			lifebar[h].show()
		else:
			lifebar[h].hide()
	if (lives > 3):
		lives = 3
		print(lives)
		
func _on_timer_timeout():
	death.play()


func _on_death_finished():
	get_tree().reload_current_scene()
