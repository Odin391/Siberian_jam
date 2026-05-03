extends Label


func _process(delta: float) -> void:
	self.text = "❤️ " + str(GlobalInfo.Gamer_health) + "/" + str(GlobalInfo.max_gamer_health)
	if GlobalInfo.Gamer_health <= 0:
		pass
