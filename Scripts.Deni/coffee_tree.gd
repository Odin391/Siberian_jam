extends Node2D

var is_in_area = false

func _on_tree_2d_body_entered(body: Node2D) -> void:
	if body as Gamer:
		is_in_area = true
	
