extends CharacterBody2D

signal hit_player
signal got_squished

@export var is_lemming = true

const SPEED = 150.0
var direction = -1
var is_alive = true

func _ready() -> void:
	$CliffDetector.enabled = not is_lemming
	if not is_lemming:
		$Sprite2D.self_modulate = Color(1,0,0,1)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if is_on_floor() and not is_lemming:
		if not $CliffDetector.is_colliding():
			direction *= -1
			$CliffDetector.position.x *= -1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if direction and is_on_floor() and is_alive:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED/30)

	move_and_slide()
	if is_on_wall():
		direction *= -1
		$CliffDetector.position.x *= -1 


func _on_hurtbox_body_entered(body: Node2D) -> void:
	scale.y=.5
	body.velocity.y = -350
	velocity = Vector2.ZERO
	is_alive = false
	$Hitbox/CollisionShape2D.set_deferred("disabled", true)
	$Hurtbox/CollisionShape2D.set_deferred("disabled", true)
	await get_tree().create_timer(1).timeout
	velocity.y = -150
	velocity.x = 100
	$CollisionShape2D.set_deferred("disabled", true)
	$Sprite2D.flip_v = true
	await get_tree().create_timer(2).timeout
	queue_free()


func _on_hitbox_body_entered(body: Node2D) -> void:
	hit_player.emit()
