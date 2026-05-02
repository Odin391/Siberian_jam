extends CharacterBody2D

@export var speed: float = 50.0
@export var tile_size: Vector2 = Vector2(38, 38)
@export var pause_seconds: float = 4.0

@export var waypoints_tile: Array[Vector2] = [
	Vector2(14, 6),
	Vector2(14, 10),
	Vector2(14, 1),
	Vector2(4, 4),
	Vector2(4, 10)
]

var target_position: Vector2
var is_waiting: bool = false
var audio_player: AudioStreamPlayer2D
var moo_sound = preload("res://Art/deti-online.com_-_balerina-kapuchino-tralalelo-tralala.mp3")

var last_index: int = -1

func _ready():
	if waypoints_tile.is_empty():
		print("Нет точек!")
		return
	
	audio_player = AudioStreamPlayer2D.new()
	audio_player.stream = moo_sound
	audio_player.max_distance = 150.0
	audio_player.attenuation = 1.5
	
	# Подключаем сигнал для бесконечного повтора
	audio_player.finished.connect(_on_audio_finished)
	add_child(audio_player)
	
	# Запускаем звук
	audio_player.play()
	
	_pick_random_target()

func _on_audio_finished():
	audio_player.play()   # перезапускаем, если не зациклено

func _physics_process(delta):
	if waypoints_tile.is_empty() or is_waiting:
		return
	
	var direction = (target_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
	
	if global_position.distance_to(target_position) < 10.0:
		is_waiting = true
		velocity = Vector2.ZERO
		# (опционально) если нужен дополнительный звук при остановке, можно раскомментировать:
		# audio_player.play()
		
		await get_tree().create_timer(pause_seconds).timeout
		_pick_random_target()
		is_waiting = false

func _pick_random_target():
	var size = waypoints_tile.size()
	if size == 0:
		return
	if size == 1:
		var tile_coord = waypoints_tile[0]
		target_position = Vector2(
			tile_coord.x * tile_size.x + tile_size.x / 2,
			tile_coord.y * tile_size.y + tile_size.y / 2
		)
		last_index = 0
		return
	
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
