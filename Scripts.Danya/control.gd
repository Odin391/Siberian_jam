extends Control
@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var panel_2: Panel = $Panel2


func _ready():
	v_box_container.visible = true
	panel_2.visible = false
	
func _on_button_4_pressed() -> void:
	v_box_container.visible = false
	panel_2.visible = true
	

#play
func _on_button_3_pressed() -> void:
	var d = load ("res://Scripts.Deni/lvl1.tscn")
	get_tree().change_scene_to_packed(d)

#exist
func _on_button_5_pressed() -> void:
	get_tree().quit()


func _on_button_pressed():
	_ready()
