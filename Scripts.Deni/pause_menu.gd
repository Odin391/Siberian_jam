extends Control

var is_paused = false

func _ready():
	hide()
	process_mode = PROCESS_MODE_ALWAYS
	get_tree().paused = false

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if is_paused:
			resume_game()
		else:
			pause_game()

func pause_game():
	is_paused = true
	get_tree().paused = true
	show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func resume_game():
	is_paused = false
	get_tree().paused = false
	hide()
	# Не меняем режим мыши – оставляем как есть (VISIBLE)
	# Можно явно установить VISIBLE, но это и так режим по умолчанию после паузы
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
