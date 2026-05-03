extends RigidBody2D
class_name Bullet


var in_action = false
var damage = 10
@onready var timer = get_node("Timer")

func _ready() -> void:
	$AnimatedSprite2D.play("new_animation")
# пускаем как торпеду, после первого нажатия одно из in_action ложно и больше нельзя перенаправить
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("LMB") and in_action == false:
		in_action = true
		look_at(get_global_mouse_position())
		var target = get_global_mouse_position()
		var direction = (target - position).normalized()
		apply_force(direction * 4000)

var smaller = false
# по таймеру времени полета уменьшаем урон и scale (размер)
func _on_timer_timeout() -> void:
	damage -= 2
	if scale >= Vector2(0, 0) and smaller == false:
		var tween = create_tween()
		tween.tween_property(self, "scale", scale * 0.1, 5)
	if damage <= 0:
		queue_free()
	smaller = true
