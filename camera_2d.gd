extends Camera2D

func _ready():
	# --- ФИКСИРУЕМ ПОЗИЦИЮ И ЗУМ ---
	position = Vector2(1080, 720)   # подберите координаты под ваше видео
	zoom = Vector2(1.9, 1.7)       # масштаб (1 = без приближения)
	
	# --- ОТКЛЮЧАЕМ ВСЁ, ЧТО ПОЗВОЛЯЕТ КАМЕРЕ ДВИГАТЬСЯ ---
	position_smoothing_enabled = false   # отключаем плавное следование
	
	# Ограничения (по умолчанию неактивны, но для надёжности обнулим)
	limit_left = 0
	limit_top = 0
	limit_right = 0
	limit_bottom = 0
	
	# Отключаем возможность перетаскивания камеры
	drag_horizontal_enabled = false
	drag_vertical_enabled = false
	
	# Отключаем обработку ввода (чтобы камера не реагировала на скролл и т.п.)
	set_process_input(false)
