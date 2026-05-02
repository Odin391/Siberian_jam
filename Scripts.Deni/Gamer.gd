extends CharacterBody2D
class_name Gamer

var speed = 40

var ProgressBarr = get_parent()

func _ready():
	add_to_group("player")   # добавляем игрока в группу для обнаружения предметами


@onready var Mana = get_parent().get_node("CanvasLayer/Mana")
@onready var koffeBall = preload("res://Scripts.Deni/bullet.tscn")

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("LMB"):
		GlobalInfo.mana_value -= 20
		_spawn()




func _process(delta: float) -> void:
	
	
	print(GlobalInfo.stamina_value)
	if GlobalInfo.stamina_value != 0.0:
		velocity.y = Input.get_axis("W", "S") * speed
		velocity.x = Input.get_axis("A", "D") * speed
	else:
		velocity = Vector2.ZERO
	
	if Input.get_axis("W", "S")!=0 or Input.get_axis("A", "D")!=0 :
		GlobalInfo.in_action = true
	else:
		GlobalInfo.in_action = false
	
	
	if Input.is_action_pressed("Shift") and GlobalInfo.stamina_value != 0:
		GlobalInfo.in_shift = true
		velocity *= 2
	else:
		GlobalInfo.in_shift = false
	
	
	
	
	move_and_slide()


func _spawn():
	var bullet = koffeBall.instantiate()
	bullet.position = self.global_position
	get_parent().add_child(bullet)
