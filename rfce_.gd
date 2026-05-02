extends Node2D




func _on_button_pressed() -> void:
	var d = load ("res://Scripts.Deni/lvl1.tscn")
	get_tree().change_scene_to_packed(d)
