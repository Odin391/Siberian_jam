extends CharacterBody2D

@export var speed: float = 50.0
@export var tile_size: Vector2 = Vector2(38, 38)
@export var pause_seconds: float = 3.0
@export var type_of_animal = ""




var waypoints_tile: Array[Vector2] = []  # Теперь пустой массив
var target_position: Vector2
var is_waiting: bool = false
var audio_player: AudioStreamPlayer2D
var rabbit_sound = preload("res://Art/the-wounded-hare-screams (online-audio-converter.com).mp3")
var last_index: int = 0

func _ready():
	
	if type_of_animal == "cow":
		var cow_sound = preload("res://Art/sounds-animals-cow-1.mp3")
		speed = 40
	
	if type_of_animal == "rabbit":
		var cow_sound = preload("res://Art/the-wounded-hare-screams (online-audio-converter.com).mp3")
		speed = 60
	
	
	generate_waypoints(5)  # Генерируем 5 точек при старте
	if waypoints_tile.is_empty():
		print("Нет точек!")
		return

	audio_player = AudioStreamPlayer2D.new()
	audio_player.stream = rabbit_sound
	audio_player.max_distance = 150.0
	audio_player.attenuation = 1.5
	audio_player.finished.connect(_on_audio_finished)
	add_child(audio_player)
	audio_player.play()
	_pick_random_target()


func _physics_process(delta):
	
	if waypoints_tile.is_empty() or is_waiting == true:
		return
	
	var direction = (target_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
	
	
	var value_of_stolknoveniya = get_slide_collision_count()
	print(value_of_stolknoveniya)
	
	if global_position.distance_to(target_position) < 10.0 or value_of_stolknoveniya>0 and is_waiting == false:
		velocity = Vector2.ZERO
		is_waiting = true
		await get_tree().create_timer(7).timeout
		_pick_random_target()
		is_waiting = false




func _on_audio_finished():
	audio_player.play()   # перезапускаем, если не зациклено


func generate_waypoints(count: int):
	waypoints_tile.clear()  # Очищаем предыдущие точки
	for i in range(count):
		var x = randi_range(GlobalInfo.min_for_cow_x, GlobalInfo.max_for_cow_x)
		var y = randi_range(GlobalInfo.min_for_cow_y, GlobalInfo.max_for_cow_y)
		waypoints_tile.append(Vector2(x, y))

func _pick_random_target():
	if last_index == 0:
		last_index += 1
		target_position = waypoints_tile[last_index]
	elif last_index < 4:
		last_index += 1
		target_position = waypoints_tile[last_index]
	elif last_index == 5:
		last_index = 0
	
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Bullet:
		$HPLabel.health -= 2
		body.queue_free()
