extends CharacterBody2D


const SPEED = 150.0
var direction = -1


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if direction and is_on_floor():
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED/30)

	move_and_slide()
	if is_on_wall():
		direction *= -1


func _on_hurtbox_body_entered(body: Node2D) -> void:
	queue_free()


func _on_hitbox_body_entered(body: Node2D) -> void:
	body.queue_free()
