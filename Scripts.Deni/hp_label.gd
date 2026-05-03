extends Label

func _ready():
	# Начальный текст (здоровье может быть ещё не установлено)
	update_text()

func _process(delta):
	update_text()

func update_text():
	var current = GlobalInfo.boss_health
	var max_hp = GlobalInfo.max_boss_health
	if current <= 0:
		text = "☕ Босс: ПОВЕРЖЕН"
	else:
		text = "☕ Босс: " + str(current) + "/" + str(max_hp)
