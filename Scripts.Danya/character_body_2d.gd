extends CharacterBody2D

@export var speed: float = 80.0
@export var tile_size: Vector2 = Vector2(38, 38)  # Размер одного тайла (подбери свой)
@export var pause_seconds: float = 5.0            # Задержка в секундах между точками

# Тайловые координаты (индексы клеток)
@export var waypoints_tile: Array[Vector2] = [
	Vector2(2, 6),
	Vector2(3, 6),
	Vector2(8, 5),
	Vector2(7, 4),
	Vector2(13, 5)
]

var target_position: Vector2   # реальная пиксельная цель
var is_waiting: bool = false

func _ready():
	if waypoints_tile.is_empty():
		print("Нет точек!")
		return
	_pick_random_target()

func _physics_process(delta):
	if waypoints_tile.is_empty() or is_waiting:
		return
	
	# Направление к цели (глобальные координаты персонажа сравниваются с пиксельной целью)
	var direction = (target_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
	
	# Если дошли до цели
	if global_position.distance_to(target_position) < 10.0:
		is_waiting = true
		velocity = Vector2.ZERO  # остановиться
		# Ждём и выбираем новую точку
		await get_tree().create_timer(pause_seconds).timeout
		_pick_random_target()
		is_waiting = false

func _pick_random_target():
	var random_index = randi() % waypoints_tile.size()
	var tile_coord = waypoints_tile[random_index]
	# Преобразуем тайловые координаты в пиксельные (центр клетки)
	target_position = Vector2(
		tile_coord.x * tile_size.x + tile_size.x / 2,
		tile_coord.y * tile_size.y + tile_size.y / 2
	)
