extends CharacterBody2D

@export var speed : float = 200.0          # скорость (пикселей/сек)
@export var attack_cooldown : float = 0.5  # задержка между атаками

var target : Node2D = null
var can_attack : bool = true
var attack_timer : float = 0.0

func _ready():
	# Небольшая задержка, чтобы игрок точно появился
	await get_tree().process_frame
	find_player()
	# Подключаем сигнал касания (если хотим атаковать строго при столкновении)
	body_entered.connect(_on_body_entered)

func find_player():
	# Ищем игрока по группе "player"
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		target = players[0]
		print("Кабан нашёл игрока: ", target.name)
	else:
		target = null
		print("Игрок не найден — проверьте группу 'player'")

func _process(delta):
	if target == null:
		# Пытаемся найти игрока каждый 1 секунду (примерно 60 кадров)
		if Engine.get_process_frames() % 60 == 0:
			find_player()
		return
	
	# 1. Вектор движения к игроку (нормализованный)
	var direction = (target.global_position - global_position).normalized()
	# 2. Перемещение без физики (просто меняем позицию)
	position += direction * speed * delta
	
	# 3. Опционально: поворот спрайта
	if has_node("Sprite2D") and direction.x != 0:
		$Sprite2D.flip_h = direction.x < 0
	
	# 4. Управление перезарядкой атаки
	if not can_attack:
		attack_timer += delta
		if attack_timer >= attack_cooldown:
			can_attack = true
			attack_timer = 0.0
	
	# 5. Дополнительная проверка "вплотную" по расстоянию (на случай, если сигнал не сработал)
	var distance = global_position.distance_to(target.global_position)
	if distance < 10.0 and can_attack:
		attack()

# Сигнал: когда Area2D кабана касается тела игрока
func _on_body_entered(body):
	if body == target and can_attack:
		attack()

func attack():
	can_attack = false
	print("Кабан атакует!")
	# У игрока должен быть метод take_damage(amount)
	if target and target.has_method("take_damage"):
		target.take_damage(1)
	else:
		print("У игрока нет метода take_damage!")
