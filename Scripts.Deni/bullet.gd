extends RigidBody2D

var in_action = false


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("LMB") and in_action == false:
		in_action = true
		var target = get_global_mouse_position()
		var direction = (target - position).normalized()
		apply_central_force(direction * 40)
