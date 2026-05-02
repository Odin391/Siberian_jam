extends Node

var items = []           # {"name": str, "icon": Texture2D, "quantity": int}
var inventory_ui = null
var player = null
var pickup_scene = null

func _ready():
	pickup_scene = preload("res://Scripts.Danya/area_2d_2.tscn")
	player = get_tree().get_first_node_in_group("player")

func add_item(name, icon):
	for i in range(items.size()):
		if items[i]["name"] == name and items[i]["icon"] == icon:
			items[i]["quantity"] += 1
			if inventory_ui: inventory_ui.refresh()
			return
	items.append({"name": name, "icon": icon, "quantity": 1})
	if inventory_ui: inventory_ui.refresh()

# Выбрасываем предмет рядом с игроком
func drop_item(index: int):
	if index < 0 or index >= items.size():
		return
	if pickup_scene == null or player == null:
		print("Ошибка: нет сцены предмета или игрока")
		return
	
	var item = items[index]
	var item_name = item["name"]
	var item_icon = item["icon"]
	
	if item["quantity"] > 1:
		item["quantity"] -= 1
	else:
		items.remove_at(index)
	
	if inventory_ui:
		inventory_ui.refresh()
	
	# Спавним предмет рядом с игроком (чуть правее)
	var pickup = pickup_scene.instantiate()
	pickup.item_name = item_name
	pickup.item_icon = item_icon
	# Позиция: чуть правее от центра игрока (можно подобрать под свою коллизию)
	var offset = Vector2(50, 0)   # смещение вправо
	pickup.global_position = player.global_position + offset
	get_tree().root.add_child(pickup)
	print("🎯 Выброшен предмет ", item_name, " рядом с игроком")
