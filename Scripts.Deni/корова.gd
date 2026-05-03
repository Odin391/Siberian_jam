extends CharacterBody2D

@export var health = 30
@export var attack_interval = 4.0
@export var coffee_shot_scene: PackedScene

var player: Node2D
var attack_timer: Timer

func _ready():
	# Устанавливаем глобальные переменные здоровья
	GlobalInfo.boss_health = health
	GlobalInfo.max_boss_health = health
	print("Здоровье босса установлено: ", GlobalInfo.boss_health)

	player = get_tree().get_first_node_in_group("player")
	if player == null:
		await get_tree().create_timer(0.5).timeout
		player = get_tree().get_first_node_in_group("player")
		if player == null:
			print("Босс: игрок не найден!")
			return

	print("✅ Игрок найден, запускаем атаки")
	attack_timer = Timer.new()
	attack_timer.wait_time = attack_interval
	attack_timer.timeout.connect(_on_attack_timer_timeout)
	add_child(attack_timer)
	attack_timer.start()

func _on_attack_timer_timeout():
	if player and coffee_shot_scene:
		attack_coffee_shot()
	else:
		print("Босс: не могу атаковать (снаряд не назначен)")

func attack_coffee_shot():
	var shot = coffee_shot_scene.instantiate()
	shot.global_position = global_position
	var dir = (player.global_position - global_position).normalized()
	shot.direction = dir
	get_tree().root.add_child(shot)

func take_damage(amount):
	health -= amount
	GlobalInfo.boss_health = health
	print("Босс получил урон, HP: ", GlobalInfo.boss_health)
	if health <= 0:
		die()

func die():
	print("Босс побеждён")
	GlobalInfo.boss_health = 0
	queue_free()
