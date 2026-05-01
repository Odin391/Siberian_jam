extends RigidBody2D

var in_action = false
var damage = 10
@onready var timer = get_node("Timer")

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("LMB") and in_action == false:
		in_action = true
		var target = get_global_mouse_position()
		var direction = (target - position).normalized()
		apply_force(direction * 3000)



func _on_timer_timeout() -> void:
	damage -= 2
	var tween = create_tween()
	tween.tween_property(self, "scale", scale * 0.8, 1)
	if damage <= 0:
		queue_free()
