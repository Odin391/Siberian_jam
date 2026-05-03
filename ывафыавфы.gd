extends Area2D

var direction = Vector2.RIGHT   # ← ОБЯЗАТЕЛЬНО объявить
var speed = 200

func _ready():
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)

func _process(delta):
	global_position += direction * speed * delta

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(5)
		queue_free()

func _on_area_entered(area):
	if area.is_in_group("player"):
		area.take_damage(5)
		queue_free()
