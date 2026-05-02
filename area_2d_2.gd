extends Area2D

@export var item_name = "Яблоко"
@export var item_icon = null   # перетащите иконку

func _ready():
	area_entered.connect(_on_area_entered)

func _on_area_entered(area):
	if area.is_in_group("player"):
		print("Добавляем ", item_name)
		InventoryManager.add_item(item_name, item_icon)
		queue_free()
