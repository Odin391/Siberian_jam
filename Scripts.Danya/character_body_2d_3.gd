extends CharacterBody2D

var speed = 80
var hp = 10
var max_hp = 10
var invincible = false
var invincible_timer = 0.0
var invincible_duration = 1.0

func _ready():
	add_to_group("player")
	print("Игрок готов, группа 'player' добавлена")

func _physics_process(delta):
	var input = Vector2(
		Input.get_axis("A", "D"),
		Input.get_axis("W", "S")
	).normalized()
	velocity = input * speed
	move_and_slide()
	
	if invincible:
		invincible_timer += delta
		if invincible_timer >= invincible_duration:
			invincible = false
			modulate.a = 1.0

func take_damage(amount: int):
	if invincible:
		print("Урон проигнорирован (неуязвимость)")
		return
	hp -= amount
	print("Игрок получил урон! HP: ", hp, "/", max_hp)
	if hp <= 0:
		die()
	else:
		invincible = true
		modulate.a = 0.5

func die():
	print("Игрок погиб")
	queue_free()

func get_hp():
	return hp

func get_max_hp():
	return max_hp
