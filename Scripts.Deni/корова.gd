extends CharacterBody2D

@export var speed: float = 40.0
@export var tile_size: Vector2 = Vector2(38, 38)
@export var pause_seconds: float = 4.0

@export var waypoints_tile: Array[Vector2] = [
	Vector2(4, 13),
	Vector2(1, 8),
	Vector2(0, 25),
	Vector2(8, 19),
	Vector2(14, 10)
]

var target_position: Vector2
var is_waiting: bool = false
var audio_player: AudioStreamPlayer2D
var moo_sound = preload("res://Art/sounds-animals-cow-1.mp3")

var last_index: int = -1   # индекс последней выбранной точки

func _ready():
	if waypoints_tile.is_empty():
		print("Нет точек!")
		return
	
	audio_player = AudioStreamPlayer2D.new()
	audio_player.stream = moo_sound
	
	# Настройка расстояния слышимости
	audio_player.max_distance = 250.0       # на каком расстоянии звук пропадает (в пикселях)
	audio_player.attenuation = 0.5          # сила затухания (чем больше, тем быстрее тише)
	
	add_child(audio_player)
	
	_pick_random_target()

func _physics_process(delta):
	if waypoints_tile.is_empty() or is_waiting:
		return
	
	var direction = (target_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
	
	if global_position.distance_to(target_position) < 10.0:
		is_waiting = true
		velocity = Vector2.ZERO
		audio_player.play()
		
		await get_tree().create_timer(pause_seconds).timeout
		_pick_random_target()
		is_waiting = false

func _pick_random_target():
	var size = waypoints_tile.size()
	if size == 0:
		return
	if size == 1:
		# если всего одна точка, вынуждены её же и выбирать
		var tile_coord = waypoints_tile[0]
		target_position = Vector2(
			tile_coord.x * tile_size.x + tile_size.x / 2,
			tile_coord.y * tile_size.y + tile_size.y / 2
		)
		last_index = 0
		return
	
	# Формируем список индексов, исключая last_index
	var available_indices = []
	for i in range(size):
		if i != last_index:
			available_indices.append(i)
	
	var random_index = available_indices[randi() % available_indices.size()]
	last_index = random_index
	var tile_coord = waypoints_tile[random_index]
	target_position = Vector2(
		tile_coord.x * tile_size.x + tile_size.x / 2,
		tile_coord.y * tile_size.y + tile_size.y / 2
	)
