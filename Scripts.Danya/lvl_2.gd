extends Node2D
@onready var button_2: Button = $Gamer/PauseMenu/Panel/Button2
@onready var panel: Panel = $Gamer/PauseMenu/Panel/Panel
@onready var button: Button = $Gamer/PauseMenu/Panel/Button






func _on_button_pressed() -> void:
	get_tree().quit()

func _ready() -> void:
	button_2.visible = true
	panel.visible = false
	button.visible = true
func _on_button_2_pressed() -> void:
	button_2.visible = false
	panel.visible = true
	button.visible = false


func _on_button_123_pressed() -> void:
	_ready()
