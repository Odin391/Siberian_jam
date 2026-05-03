extends CharacterBody2D

@export var interaction_distance = 50.0
@export var dialogue_text = "Удачи тебе. Я пытался вас примирить,
 но у меня не получилось."

var can_interact = false
var player: Node2D
var interacted = false

@onready var label = $Label   # дочерний узел Label

func _ready():
	add_to_group("elder_before_boss")
	player = get_tree().get_first_node_in_group("player")
	if label:
		label.text = ""   # пока пусто
		label.visible = true

func _physics_process(delta):
	if interacted:
		return
	if not player:
		player = get_tree().get_first_node_in_group("player")
		return
	var dist = global_position.distance_to(player.global_position)
	can_interact = dist < interaction_distance
	if label:
		# Показываем подсказку только когда игрок рядом
		label.text = "Нажми F" if can_interact else ""

func _input(event):
	if event.is_action_pressed("interact") and can_interact and not interacted:
		interacted = true
		if label:
			label.text = dialogue_text   # основной текст
			await get_tree().create_timer(4.0).timeout
			label.visible = false
		else:
			print(dialogue_text)
		queue_free()   # удаляем старца после диалога
