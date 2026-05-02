extends AnimatedSprite2D

func _process(delta: float) -> void:
	if GlobalInfo.in_shift == true:
		speed_scale = 1.5
	else:
		speed_scale = 1
