extends Area2D

func _ready():
	area_entered.connect(_on_collect)

func _on_collect(area):
	if area.is_in_group("player"):
		Inventory.add_coin()   # добавляем монету
		queue_free()           # монета исчезает
