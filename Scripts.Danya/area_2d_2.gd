extends Area2D

@export var speed: float = 80.0
@export var damage: int = 2
@export var attack_cooldown: float = 1.0
@export var attack_range: float = 0.5   # дистанция, на которой атакует (в ваших единицах)

var player = false
var can_attack = true
var attack_timer = 4.0

@onready var sprite = $Sprite2D

func _ready():
	player = get_tree().get_first_node_in_group("player")
	if not player:
		print("Кабан: игрок не найден")

func _physics_process(delta):
	if not player:
		return
	
	# 1. Движение к игроку
	var direction = (player.global_position - global_position).normalized()
	position += direction * speed * delta
	
	# Поворот спрайта
	if direction.x != 0:
		sprite.scale.x = abs(sprite.scale.x) if direction.x > 0 else -abs(sprite.scale.x)
	
	# 2. Расстояние до игрока
	var distance = global_position.distance_to(player.global_position)
	
	# 3. Атака только если очень близко и можно атаковать
	if distance <= attack_range and can_attack:
		can_attack = false
		attack_timer = 0.0
		if player.has_method("take_damage"):
			player.take_damage(damage)
			print("⚔️ КАБАН АТАКУЕТ! Урон ", damage, ", HP игрока: ", player.hp)
		else:
			print("Ошибка: у игрока нет метода take_damage")
	
	# 4. Таймер перезарядки атаки
	if not can_attack:
		attack_timer += delta
		if attack_timer >= attack_cooldown:
			can_attack = true
