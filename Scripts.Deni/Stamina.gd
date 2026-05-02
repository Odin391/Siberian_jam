extends ProgressBar



func _process(delta: float) -> void:
	if GlobalInfo.in_action == false:
		if value + 0.3 > max_value:
			value += max_value - value
		else:
			value += 0.3
	elif GlobalInfo.in_action == true:
		if GlobalInfo.in_shift == false:
			if value - 0.1 < min_value:
				value = min_value + value
			else:
				value -= 0.1
		if GlobalInfo.in_shift == true:
			if value - 0.2 < min_value:
				value = min_value + value
			else:
				value -= 0.2
	
	
	GlobalInfo.stamina_value = self.value
