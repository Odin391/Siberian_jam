extends RigidBody2D
class_name Bullet

var in_action = false
var damage = 10
@onready var timer = $Timer

func _ready() -> void:
	$AnimatedSprite2D.play("new_animation")
	# подключаем сигнал столкновения
	body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("LMB") and in_action == false:
		in_action = true
		look_at(get_global_mouse_position())
		var target = get_global_mouse_position()
		var direction = (target - position).normalized()
		apply_force(direction * 4000)

var smaller = false

func _on_timer_timeout() -> void:
	damage -= 2
	if scale >= Vector2(0, 0) and smaller == false:
		var tween = create_tween()
		tween.tween_property(self, "scale", scale * 0.1, 5)
	if damage <= 0:
		queue_free()
	smaller = true

# Добавленная функция обработки столкновения
func _on_body_entered(body: Node2D) -> void:
	# Если попали в босса (или любого врага с группой "boss" или "enemy")
	if body.is_in_group("boss") or body.is_in_group("enemy"):
		# Проверяем, есть ли у цели метод take_damage
		if body.has_method("take_damage"):
			body.take_damage(damage)
		# Уничтожаем пулю
		queue_free()
