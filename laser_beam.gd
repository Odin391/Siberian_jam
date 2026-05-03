extends Area2D

var damage = 2
var rotation_speed = 2 * PI / 5.0  # полный оборот за 5 секунд
var radius = 100.0
var lifetime = 5.0
var current_angle = 0.0

@onready var boss = get_parent()   # предполагаем, что лазер добавлен как дочерний босса

func _ready():
	body_entered.connect(_on_body_entered)
	current_angle = randf_range(0, 2*PI)   # случайный начальный угол
	_update_position()
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _process(delta):
	current_angle += rotation_speed * delta
	_update_position()
	rotation = current_angle   # поворачиваем лазер в направлении

func _update_position():
	position = Vector2(cos(current_angle), sin(current_angle)) * radius

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(damage)
