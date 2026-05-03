extends Node2D

var is_in_area = false

	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body as Gamer:
		is_in_area = true
		$Label.visible = true

func  _process(delta: float) -> void:
	if is_in_area == true:
		if Input.is_action_just_pressed("RMB"):
			queue_free()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body as Gamer:
		is_in_area = false
		$Label.visible = false
