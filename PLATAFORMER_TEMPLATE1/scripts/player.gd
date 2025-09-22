extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -350.0
@onready var anim = $anim
@onready var flipped = false
@onready var isAttacking = false
@onready var timer = $Timer
@onready var damage_timer = $DamageTimer
@onready var sound_fx_damage = $SoundFX_Damage
@onready var damaged = false
@onready var hitbox = $hitbox/hitbox
@onready var hurtbox = $hurtbox/hurtbox

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var game_manager: Node = %GameManager
@onready var attack_fx: AudioStreamPlayer2D = $"Attack FX"


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#knockback
func _knockback(_delta):
	if Input.is_action_just_pressed("zed"):
		print("zed pressed")
		#position.x += 300 * delta
		#velocity = Vector2(-100,-30) * 10

#movement
func _physics_process(delta):
	_knockback(delta)
	velocity = velocity.move_toward(Vector2.ZERO, 100 * delta)
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
		
	
	# Get the input direction and handle the movement/deceleration.
	
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


	move_and_slide()
	animation_sprite(direction)
	
#animation
func animation_sprite(direction):
	if damaged == true:
		anim.play("damage")
	if isAttacking == false:
		if direction > 0 and is_on_floor():
			anim.flip_h = false
			anim.play("walk")
			anim.offset = Vector2(0,0)
			flipped = false
			
		if direction < 0 and is_on_floor():
			anim.flip_h = true
			anim.play("walk")
			anim.offset = Vector2(0,0)
			flipped = true
		if direction == 0 and is_on_floor():
			anim.play("idle")
			anim.offset = Vector2(0,0)
		
		if velocity.y < 0 and not is_on_floor() and damaged == false:
			anim.play("jump")
			if flipped == true:
				anim.offset = Vector2(0,0)
			if flipped == false:
				anim.offset = Vector2(0,0)
		elif velocity.y > 0 and not is_on_floor() and damaged == false:
			anim.play("fall")
			if flipped == true:
				anim.offset = Vector2(-5,-15)
			if flipped == false:
				anim.offset = Vector2(5,-15)
			
		##attack animations
		
	elif isAttacking == true:
		if direction > 0 and is_on_floor():
			anim.flip_h = false
			anim.play("attack_meele_walk")
			anim.offset = Vector2(17,-3)
			flipped = false
		if direction < 0 and is_on_floor():
			anim.flip_h = true
			anim.play("attack_meele_walk")
			anim.offset = Vector2(-16,-3)
			flipped = true
		if direction == 0 and is_on_floor():
			if flipped == false:
				anim.play("attack_meele_idle")
				anim.offset = Vector2(19,-8)
			if flipped == true:
				anim.play("attack_meele_idle")
				anim.offset = Vector2(-19,-8)
				
		if velocity.y < 0 and not is_on_floor():
			if flipped == false:
				anim.play("attack_meele_jump")
				anim.offset = Vector2(16,0)
			if flipped == true:
				anim.play("attack_meele_jump")
				anim.offset = Vector2(-16,0)
				
		elif velocity.y > 0 and not is_on_floor():
			if flipped == false:
				anim.play("attack_meele_fall")
				anim.offset = Vector2(21,-15)
			if flipped == true:
				anim.play("attack_meele_fall")
				anim.offset = Vector2(-21,-15)
		



#attack
func _input(_event):
	if Input.is_action_just_pressed("attack_meele"):
		isAttacking = true
		attack_fx.play()
		if flipped == false:
			hitbox.set_deferred("disabled", false)
			hitbox.position = Vector2(34,2)
			timer.start()
		elif flipped == true:
			hitbox.set_deferred("disabled", false)
			hitbox.position = Vector2(-30,2)
			timer.start()
func _on_timer_timeout():
	isAttacking = false
	hitbox.set_deferred("disabled", true)



func _on_hurtbox_area_entered(area):
	if area.name == "damageprop" or "enemyhurtbox":
		game_manager.decrease_health()
		hurtbox.set_deferred("disabled", true)
		damaged = true
		velocity = Vector2.UP * 300
		#velocity = Vector2(0,-30) * 10
		sound_fx_damage.play()
		damage_timer.start()


func _on_damage_timer_timeout():
	hurtbox.set_deferred("disabled", false)
	damaged = false
	
