extends CharacterBody2D

var speed = 40

func _ready():
	add_to_group("player")   # добавляем игрока в группу для обнаружения предметами

func _process(delta: float) -> void:
	velocity.y = Input.get_axis("W", "S") * speed
	velocity.x = Input.get_axis("A", "D") * speed
	
	if Input.is_action_pressed("Shift"):
		velocity *= 2
	move_and_slide()
	
	
