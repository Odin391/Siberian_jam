extends Node2D
@onready var button_2: Button = $Gamer/PauseMenu/Panel/Button2
@onready var panel: Panel = $Gamer/PauseMenu/Panel/Panel
@onready var button: Button = $Gamer/PauseMenu/Panel/Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button_2.visible = true
	panel.visible = false
	button.visible = true
func _on_button_2_pressed() -> void:
	button_2.visible = false
	panel.visible = true
	button.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().quit()
	

	



func _on_button_123_pressed() -> void:
	_ready()
