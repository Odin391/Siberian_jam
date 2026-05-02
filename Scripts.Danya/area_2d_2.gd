extends Area2D

@export var speed : float = 20.0          # скорость (пикселей/сек)
@export var attack_cooldown : float = 0.5  # задержка между атаками

var target : Node2D = null
var can_attack : bool = true
var attack_timer : float = 0.0

func _ready():
	target = get_tree().get_first_node_in_group("player")
	if target == null:
		print("Ошибка: группа 'player' не найдена")
	body_entered.connect(_on_body_entered)

func _process(delta):
	if target == null:
		return
	
	# Вектор направления к игроку (нормализованный)
	var direction = (target.global_position - global_position).normalized()
	# ДВИЖЕНИЕ ВПЛОТНУЮ БЕЗ ОСТАНОВКИ
	position += direction * speed * delta
	
	# Поворот спрайта (опционально)
	if direction.x != 0 and has_node("Sprite2D"):
		$Sprite2D.flip_h = direction.x < 0
	
	# Перезарядка атаки
	if not can_attack:
		attack_timer += delta
		if attack_timer >= attack_cooldown:
			can_attack = true
			attack_timer = 0.0

func _on_body_entered(body):
	# Когда кабан ВПЛОТНУЮ столкнулся с игроком
	if body == target and can_attack:
		can_attack = false
		print("Кабан врезался и атакует!")
		if body.has_method("take_damage"):
			body.take_damage(1)
