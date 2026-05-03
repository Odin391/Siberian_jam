extends CharacterBody2D

@export var speed: float = 40.0
@export var walk_direction: Vector2 = Vector2.RIGHT
@export var required_item_name: String = "Кофейные зёрна"
@export var required_item_icon: Texture2D = null
@export var interaction_distance: float = 150.0

var can_interact = false
var is_active = false
var is_waiting_for_item = false
var disappear_timer: Timer

@onready var label = $Label

func _ready():
	if label:
		label.visible = true
		label.text = "Нажми на F"
	disappear_timer = Timer.new()
	disappear_timer.one_shot = true
	disappear_timer.timeout.connect(_on_disappear)
	add_child(disappear_timer)

func _physics_process(delta):
	if is_active:
		velocity = walk_direction * speed
		move_and_slide()
		return

	if QuestState.stage < QuestState.TALKED_TO_FIRST:
		can_interact = false
		if label:
			label.text = "***"
		return

	if QuestState.stage == QuestState.TALKED_TO_FIRST:
		if label:
			label.text = "Подойди, путник"
	elif QuestState.stage == QuestState.RECEIVED_QUEST:
		if label:
			label.text = "Принеси " + required_item_name
	elif QuestState.stage >= QuestState.QUEST_COMPLETED:
		if label:
			label.visible = false
		return

	var player = get_tree().get_first_node_in_group("player")
	if player:
		var dist = global_position.distance_to(player.global_position)
		can_interact = dist < interaction_distance
	else:
		can_interact = false

func _input(event):
	if event.is_action_pressed("interact") and can_interact and not is_active:
		if QuestState.stage == QuestState.TALKED_TO_FIRST:
			start_quest()
		elif QuestState.stage == QuestState.RECEIVED_QUEST:
			check_and_complete_quest()

func start_quest():
	QuestState.advance_to_next_stage()
	print("Второй старец: Принеси мне кофейные зёрна")
	if label:
		label.text = "Принеси " + required_item_name
	
	# РАСШИРЕННЫЙ ТЕКСТ ПЕРВОГО ДИАЛОГА
	var long_text = (
        "Старец у реки:\n"
		+ "«Ты пришёл, путник. Знаю, тебя отправил мой брат.\n"
		+ "Он рассказал о твоей беде. Лте и Лавандовый раб действительно прогневались.\n"
		+ "Но чтобы открылась тропа к Забытому источнику, нужен особый дар.\n"
		+ "Принеси мне кофейные зёрна – только они смогут разбудить древнюю силу.\n"
		+ "Я буду ждать здесь. Не медли, время уходит.»"
	)
	show_dialogue(long_text)

func check_and_complete_quest():
	var has_item = false
	var item_index = -1
	for i in range(InventoryManager.items.size()):
		if InventoryManager.items[i]["name"] == required_item_name:
			has_item = true
			item_index = i
			break
	
	if has_item:
		InventoryManager.remove_item_at(item_index)
		QuestState.advance_to_next_stage()
		print("Старец: Спасибо! Теперь иди по реке, найдёшь тропинку к босу.")
		
		# РАСШИРЕННЫЙ ТЕКСТ БЛАГОДАРНОСТИ
		var thanks_text = (
            "Старец, принимая зёрна:\n"
			+ "«Воистину, ты достоин. Эти зёрна — ключ к твоему испытанию.\n"
			+ "Ступай вдоль реки на восток. Через полсотни шагов увидишь старую иву.\n"
			+ "Там начнётся тропа, что приведёт тебя к Хранителю Кофейного мира.\n"
			+ "Но будь осторожен: он не прощает ошибок. И помни, выбор за тобой.»\n"
			+ "С этими словами старец растворяется в утреннем тумане."
		)
		show_dialogue(thanks_text)
		
		is_active = true
		disappear_timer.start(10.0)
		if label:
			label.visible = false
	else:
		print("Старец: У тебя нет " + required_item_name)
		var no_item_text = (
            "«Ты пришёл с пустыми руками? Кофейные зёрна не растут на деревьях.\n"
			+ "Ищи их у торговцев или на развалинах старой мельницы.\n"
			+ "Вернешься с зёрнами – поговорим.»"
		)
		show_dialogue(no_item_text)

func show_dialogue(text: String):
	if label:
		var old_text = label.text
		label.text = text
		# Увеличим время отображения длинного текста
		var display_time = 5.0 if len(text) > 100 else 3.0
		await get_tree().create_timer(display_time).timeout
		label.text = old_text
	else:
		print(text)

func _on_disappear():
	queue_free()
