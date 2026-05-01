extends CanvasLayer

@onready var hp_label: Label = $HPLabel
func _ready():
	# Ищем игрока и подписываемся на сигнал (если игрок умеет посылать сигнал)
	# Но проще обновлять каждый кадр
	pass


func _process(delta):
	var player = get_tree().get_first_node_in_group("player")
	if player and player.has_method("get_hp"):
		hp_label.text = "❤️ " + str(player.get_hp()) + "/" + str(player.get_max_hp())
	elif player:
		# Если нет get_hp, обращаемся напрямую к переменной (не рекомендуется, но работает)
		hp_label.text = "❤️ " + str(player.hp) + "/" + str(player.max_hp)
