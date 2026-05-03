extends Control

@onready var item_list = $Panel/ItemList
var open = false

func _ready():
	hide()
	InventoryManager.inventory_ui = self
	item_list.item_clicked.connect(_on_item_list_clicked)

func _input(event):
	if event.is_action_pressed("inventory"):
		open = !open
		if open:
			refresh()
			show()
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			hide()

func refresh():
	item_list.clear()
	for item in InventoryManager.items:
		item_list.add_item(item["name"] + " x" + str(item["quantity"]), item["icon"])

func _on_item_list_clicked(index, at_position, mouse_button):
	if mouse_button == MOUSE_BUTTON_RIGHT:   # ПКМ
		InventoryManager.drop_item(index)
