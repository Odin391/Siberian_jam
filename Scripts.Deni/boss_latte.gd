extends CharacterBody2D

@export var health = 30
@export var attack_interval = 2.0
@export var attack_range = 300.0
@export var coffee_shot_scene: PackedScene
@export var laser_beam_scene: PackedScene   # сюда перетащить LaserBeam.tscn

var player: Node2D
var attack_timer: Timer
var laser_timer: Timer

func _ready():
	player = get_tree().get_first_node_in_group("player")
	if not player:
		await get_tree().create_timer(0.5).timeout
		player = get_tree().get_first_node_in_group("player")
	
	# Таймер для атак кофе
	attack_timer = Timer.new()
	attack_timer.wait_time = attack_interval
	attack_timer.timeout.connect(_on_attack_timer_timeout)
	add_child(attack_timer)
	attack_timer.start()
	
	# Таймер для лазерной атаки (раз в 30 секунд)
	laser_timer = Timer.new()
	laser_timer.wait_time = 10.0
	laser_timer.timeout.connect(_spawn_laser)
	add_child(laser_timer)
	laser_timer.start()

func _on_attack_timer_timeout():
	if not player or not coffee_shot_scene:
		return
	if global_position.distance_to(player.global_position) <= attack_range:
		attack_coffee_shot()

func attack_coffee_shot():
	var shot = coffee_shot_scene.instantiate()
	shot.global_position = global_position
	shot.direction = (player.global_position - global_position).normalized()
	get_tree().root.add_child(shot)

func _spawn_laser():
	if laser_beam_scene:
		var laser = laser_beam_scene.instantiate()
		add_child(laser)   # лазер становится дочерним босса

func take_damage(amount):
	health -= amount
	if health <= 0:
		die()

func die():
	if attack_timer: attack_timer.queue_free()
	if laser_timer: laser_timer.queue_free()
	queue_free()
