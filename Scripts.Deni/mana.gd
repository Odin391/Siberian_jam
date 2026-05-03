extends ProgressBar


func _process(delta: float) -> void:
	self.value = GlobalInfo.mana_value
	GlobalInfo.mana_value += 0.01
