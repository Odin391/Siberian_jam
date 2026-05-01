extends CharacterBody2D

var speed = 40

@onready var koffeBall = preload("res://Scripts.Deni/bullet.tscn")

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("LMB"):
		_spawn()



func _process(delta: float) -> void:
	velocity.y = Input.get_axis("W", "S") * speed
	velocity.x = Input.get_axis("A", "D") * speed
	
	if Input.is_action_pressed("Shift"):
		velocity *= 2
	
	move_and_slide()


func _spawn():
	var bullet = koffeBall.instantiate()
	bullet.position = self.global_position
	get_parent().add_child(bullet)
