extends Control

var is_paused = false

func _ready():
	hide()
	# Убедимся, что панель продолжает работать даже когда игра на паузе
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause():
	if is_paused:
		# Снять паузу
		get_tree().paused = false
		hide()
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		is_paused = false
	else:
		# Поставить паузу
		get_tree().paused = true
		show()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		is_paused = true
