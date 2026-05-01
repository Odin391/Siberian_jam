extends Area2D

var speed = 200

func _ready():
	add_to_group("player")   # для обнаружения предметами

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
