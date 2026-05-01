extends Node2D

@onready var items_container = $Panel/VBoxContainer/ItemsList  # укажите свой путь
@onready var panel = $Panel

func _ready():
	# Подписываемся на сигнал обновления инвентаря
	Inventory.inventory_updated.connect(update_inventory_display)
	update_inventory_display()  # начальное обновление

func update_inventory_display():
	# Очищаем старые элементы
	for child in items_container.get_children():
		child.queue_free()
	
	# Добавляем новые строки для каждого предмета
	for item_name in Inventory.get_items():
		var amount = Inventory.get_items()[item_name]
		var label = Label.new()
		label.text = str(item_name) + " x" + str(amount)
		items_container.add_child(label)

# Открыть/закрыть инвентарь
func toggle_inventory():
	visible = !visible
	if visible:
		update_inventory_display()  # обновляем перед показом

# Закрыть по кнопке (можно добавить сигнал pressed)
func _on_close_button_pressed():
	visible = false
