extends Area2D

@export var item_name = "Яблоко"
@export var item_icon = null   # перетащите иконку

func _ready():
	body_entered.connect(_on_area_body)

func _on_area_body(body):
	if body as Gamer:
		print("Добавляем ", item_name)
		InventoryManager.add_item(item_name, item_icon)
		queue_free()
