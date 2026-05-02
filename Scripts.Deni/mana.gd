extends ProgressBar


func _process(delta: float) -> void:
	self.value = GlobalInfo.mana_value
