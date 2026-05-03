extends CharacterBody2D
class_name Gamer

var speed = 40

func _ready():
	add_to_group("player")
	GlobalInfo.Gamer_health = GlobalInfo.max_gamer_health   # убедитесь, что эти переменные объявлены в GlobalInfo

@onready var Mana = get_parent().get_node("CanvasLayer/Mana")
@onready var koffeBall = preload("res://Scripts.Deni/bullet.tscn")

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("LMB"):
		if GlobalInfo.mana_value != 0:
			_spawn()
			GlobalInfo.mana_value -= 20

func _process(delta: float) -> void:
	if GlobalInfo.stamina_value > 0.0:
		velocity.y = Input.get_axis("W", "S") * speed
		velocity.x = Input.get_axis("A", "D") * speed
	else:
		velocity = Vector2.ZERO
	
	if Input.get_axis("W", "S")!=0 or Input.get_axis("A", "D")!=0 :
		GlobalInfo.in_action = true
	else:
		GlobalInfo.in_action = false
	

	if Input.is_action_pressed("Shift") and GlobalInfo.stamina_value > 0:

		GlobalInfo.in_shift = true
		velocity *= 2
	else:
		GlobalInfo.in_shift = false
	
	if velocity == Vector2.ZERO:
		$Sprite2D.play("idle")
	elif velocity.y > 0:
		$Sprite2D.play("go_forward")
	elif velocity.y < 0:
		$Sprite2D.play("go_back")
	elif velocity <= Vector2(-1, -1) or velocity <= Vector2(-1, 1):
		$Sprite2D.play("go_left")
	elif velocity.x > 0:
		$Sprite2D.play("go_right")
	
	move_and_slide()

func _spawn():
	var bullet = koffeBall.instantiate()
	bullet.position = self.global_position
	get_parent().add_child(bullet)

func take_damage(amount: int):
	GlobalInfo.Gamer_health -= amount
	print("Игрок получил урон, HP: ", GlobalInfo.Gamer_health)
	if GlobalInfo.Gamer_health <= 0:
		die()

func die():
	print("Игрок умер")
	# тут можно перезапустить сцену
