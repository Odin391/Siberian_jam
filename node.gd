extends Node

var items: Array[Dictionary] = []   # каждый предмет: {"name": str, "icon": Texture2D}
var ui = null   # ссылка на UI инвентаря

func _ready():
	# Поиск UI после появления сцены
	await get_tree().process_frame
	ui = get_tree().root.get_node_or_null("Main/InventoryUI")  # укажите свой путь

func add_item(item_name: String, item_icon: Texture2D):
	items.append({"name": item_name, "icon": item_icon})
	_update_ui()

func remove_item(index: int):
	items.remove_at(index)
	_update_ui()

func _update_ui():
	if ui and ui.has_method("refresh"):
		ui.refresh()
