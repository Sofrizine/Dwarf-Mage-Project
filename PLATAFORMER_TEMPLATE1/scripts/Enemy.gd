extends CharacterBody2D
@onready var game_manager = %GameManager
@onready var enemyhurtbox = $enemyhurtbox
@onready var enemyhitbox = $enemyhitbox
@onready var collision_shape_2d = $CollisionShape2D

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var attack: AudioStreamPlayer2D = $attack
@onready var attack_timer: Timer = $"attack/attack timer"




const SPEED = 60
#var motion = Vector2()
#var gravity = 20
var direction = -1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	if ray_cast_right.is_colliding():
		direction = -1
		print(direction)
	if ray_cast_left.is_colliding():
		direction = 1
		print(direction)
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		position.x += direction * SPEED * delta
		
	move_and_slide()
	




func _on_enemyhitbox_area_entered(area):
	if area.name == "hitbox":
		attack.play()
		attack_timer.start()

func _on_attack_timer_timeout():
		queue_free()
