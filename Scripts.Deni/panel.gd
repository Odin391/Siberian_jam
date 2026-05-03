extends ColorRect

func _process(delta: float) -> void:
	$AnimationPlayer.play("WAKE_UP")
	await get_tree().create_timer(4.05).timeout
	queue_free()
