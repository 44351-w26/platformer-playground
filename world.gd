extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_kill_plane_body_entered(body: Node2D) -> void:
	body.position = $PlayerSpawn.position


func _on_enemy_hit_player() -> void:
	$Player.position = $PlayerSpawn.position


func _on_event_trigger_body_entered(body: Node2D) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($Secret, "self_modulate",
						 Color.TRANSPARENT,.5)
	


func _on_event_trigger_body_exited(body: Node2D) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($Secret, "self_modulate",
						 Color.WHITE,.5)
