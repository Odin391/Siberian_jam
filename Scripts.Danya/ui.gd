extends Label

var health = 5
var max_health = 5

func _process(delta: float) -> void:
	self.text = "❤️ " + str(health) + "/" + str(max_health)
	if health <= 0:
		visible = false
		get_parent().speed *= 0
		var animation = get_parent().get_node("AnimationPlayer")
		animation.play("death")
		await get_tree().create_timer(1.0).timeout
		get_parent().queue_free()
