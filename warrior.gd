extends CharacterBody2D
@onready var sprite = $Sprite2D
@onready var animations = %AnimationPlayer
const walking_speed = 600.0
var isAttacking = false
var horizontal_direction = 0

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("p1_attack"):
		isAttacking = true
		animations.play("attack")
		
	var direction = Input.get_vector("p1_move_left", "p1_move_right", "p1_move_up", "p1_move_down")
	horizontal_direction = direction.x
	if isAttacking:
		velocity = Vector2.ZERO
	else:
		velocity = direction * walking_speed

	var velocity_length = velocity.length()	
	
	move_and_slide()
	flip_sprite(horizontal_direction)
	update_animation(velocity_length)
	
	
	
	
func play_idle_animation():
	animations.play("idle")

func play_run_animation():
	animations.play("run")
	
func play_attack_animation():
	animations.play("attack")

func update_animation(velocity_length):
	if isAttacking: return
	
	if velocity_length > 0:
		play_run_animation()
	else:
		play_idle_animation()
	
			
func flip_sprite(horizontal_direction):
	if (horizontal_direction != 0 && !isAttacking ):
		if horizontal_direction < 0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false	
	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack":
		if(InputBuffer.is_action_press_buffered("attack")):
			if (horizontal_direction != 0):
				if horizontal_direction < 0:
					sprite.flip_h = true
				else:
					sprite.flip_h = false	
			isAttacking = true
			animations.play("attack")
		else:
			isAttacking = false
		
	else:
		isAttacking = false	
