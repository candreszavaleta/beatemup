extends CharacterBody2D
const max_walkspeed = 200.0
const walk_acceleration = 200.0

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 600
	if velocity.length() > 0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
		

	move_and_slide()
	
	
