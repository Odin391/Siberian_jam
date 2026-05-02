extends Area2D

var speed = 80
var hp = 10
var max_hp = 10

func _ready():
	add_to_group("player")
	print("Игрок готов, HP = ", hp)

func _process(delta):
	var input = Vector2(
		Input.get_axis("A", "D"),
		Input.get_axis("W", "S")
	).normalized()
	position += input * speed * delta

func _input(event):
	if event.is_action_pressed("open_inventory"):
		var ui = get_tree().root.get_node_or_null("InventoryUI")
		if ui:
			ui.toggle()

func take_damage(amount: int):
	hp -= amount
	print("Игрок получил урон! HP: ", hp, "/", max_hp)
	if hp <= 0:
		die()

func die():
	print("Игрок погиб")
	queue_free()
	# Добавь в конец класса Gamer.gd
func get_hp():
	return hp
