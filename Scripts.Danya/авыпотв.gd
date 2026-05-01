extends CharacterBody2D

# Настройки
@export var speed: float = 60.0
@export var detection_radius: float = 96.0   # 3 клетки (32*3)
@export var attack_radius: float = 48.0      # 1.5 клетки
@export var attack_cooldown: float = 1.5
@export var damage: int = 2

# Внутренние переменные
var player: Area2D = null
var waypoints: Array = []          # массив из 5 векторов
var current_target_index: int = -1
var last_target_index: int = -1
var move_direction: Vector2 = Vector2.ZERO
var can_attack: bool = true

@onready var sprite = $Sprite2D

func _ready():
	# Назначаем 5 точек маршрута (относительные координаты от текущей позиции кабана)
	# Можно задать вручную или переопределить в инспекторе
	_define_waypoints()
	
	# Поиск игрока по группе
	player = get_tree().get_first_node_in_group("player")
	if not player:
		print("Ошибка: игрок не найден!")
		return
	
	# Выбираем случайную стартовую точку
	_choose_random_waypoint()
	print("Кабан готов, маршрут из 5 точек")

func _define_waypoints():
	# Здесь задай реальные координаты на карте (пример)
	# Лучше переопределить в инспекторе как экспорт, но для простоты задаём относительные
	var start_pos = global_position
	waypoints = [
		start_pos + Vector2(1, 0),
		start_pos + Vector2(0, 6),
		start_pos + Vector2(4, 1),
		start_pos + Vector2(12, 0),
		start_pos + Vector2(6, 8)
	]

func _choose_random_waypoint():
	var available_indices = []
	for i in range(waypoints.size()):
		if i != current_target_index:
			available_indices.append(i)
	if available_indices.is_empty():
		available_indices = range(waypoints.size())
	var new_index = available_indices[randi() % available_indices.size()]
	current_target_index = new_index

func _physics_process(delta):
	if not player:
		return
	
	var dist_to_player = global_position.distance_to(player.global_position)
	
	# Если игрок в радиусе атаки
	if dist_to_player <= attack_radius and can_attack:
		velocity = Vector2.ZERO
		_attack()
		move_and_slide()
		return
	
	# Если игрок в радиусе обнаружения - преследовать
	if dist_to_player <= detection_radius:
		var dir = (player.global_position - global_position).normalized()
		velocity = dir * speed
		_flip_sprite(dir.x)
		move_and_slide()
		return
	
	# Иначе движение по маршрутным точкам
	var target_pos = waypoints[current_target_index]
	var distance_to_target = global_position.distance_to(target_pos)
	
	if distance_to_target < 10.0:   # достигли точки
		_choose_random_waypoint()
		target_pos = waypoints[current_target_index]
	
	var dir = (target_pos - global_position).normalized()
	velocity = dir * speed
	_flip_sprite(dir.x)
	move_and_slide()

func _flip_sprite(x_dir: float):
	if x_dir > 0:
		sprite.scale.x = abs(sprite.scale.x)
	elif x_dir < 0:
		sprite.scale.x = -abs(sprite.scale.x)

func _attack():
	can_attack = false
	# Наносим урон игроку
	if player and player.has_method("take_damage"):
		player.take_damage(damage)
	else:
		print("Кабан атакует, но у игрока нет метода take_damage")
	
	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true
