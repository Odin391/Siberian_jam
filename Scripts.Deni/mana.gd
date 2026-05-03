extends ProgressBar


func _process(delta: float) -> void:
	self.value = GlobalInfo.mana_value
	if GlobalInfo.mana_value + 0.01 > max_value:
		GlobalInfo.mana_value += max_value - GlobalInfo.mana_value
	else:
		GlobalInfo.mana_value += 0.01
