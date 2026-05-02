extends Node2D

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# Проверяем, не кликнули ли по UI инвентаря
		var inv_ui = InventoryManager.inventory_ui
		if inv_ui and inv_ui.visible and inv_ui.get_global_rect().has_point(get_global_mouse_position()):
			return
		
		# Получаем мировые координаты через камеру
		var camera = get_viewport().get_camera_2d()
		if camera == null:
			print("Камера не найдена")
			return
		
		# Экраные координаты мыши (в пикселях)
		var mouse_screen = get_viewport().get_mouse_position()
		# Преобразуем в мировые координаты с учётом зума и позиции камеры
		var world_mouse = camera.global_position + (mouse_screen - get_viewport().get_visible_rect().size / 2) * camera.zoom
		
		print("Клик в мире: ", world_mouse)
		InventoryManager.drop_selected_at_position(world_mouse)
