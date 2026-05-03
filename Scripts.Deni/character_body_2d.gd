extends CharacterBody2D

@export var speed: float = 40.0            # скорость после диалога
@export var walk_direction: Vector2 = Vector2.UP
@export var interaction_distance: float = 150.0

var can_interact = false
var is_active = false      # движется ли сейчас
var is_talking = false     # говорит ли сейчас (чтобы не прервать)
var disappear_timer: Timer

@onready var label = $Label

func _ready():
	if label:
		label.visible = true
		label.text = "нажми на F"
	
	disappear_timer = Timer.new()
	disappear_timer.one_shot = true
	disappear_timer.timeout.connect(_on_disappear)
	add_child(disappear_timer)

func _physics_process(delta):
	if is_active:
		velocity = walk_direction * speed
		move_and_slide()
		return
	
	if not is_talking:
		var player = get_tree().get_first_node_in_group("player")
		if player:
			var dist = global_position.distance_to(player.global_position)
			can_interact = dist < interaction_distance
		else:
			can_interact = false

func _input(event):
	if event.is_action_pressed("interact") and can_interact and not is_active and not is_talking:
		start_dialogue_sequence()

func start_dialogue_sequence():
	is_talking = true
	# Первая фраза
	if label:
		label.visible = true
		label.text = "А, вот и наш горе-гость... 
		Ты, наверное, удивлён, 
		почему вместо офиса оказался в этом латте-аду."
		await get_tree().create_timer(10.0).timeout
		
		# Вторая фраза
		label.text = "Знаешь, Лате и Лаванда — дамы с характером.
		 Они не прощают неуважения. 
		Пролить латте на лаванду — это всё равно что плюнуть в душу утра. 
		Теперь твой путь лежит через эту равнину — никто ещё не проходил дальше :"
		await get_tree().create_timer(16.0).timeout
		
		# Третья фраза
		label.text = "Мне пора на варку. 
		А ты ступай к реке — там твоё первое испытание. 
		И помни: уважение к мелочам возвращает домой."
		await get_tree().create_timer(14.0).timeout
		
		label.visible = false
	
	# *** ВАЖНО: переключаем этап квеста, чтобы второй старец начал работать ***
	QuestState.advance_to_next_stage()   # stage становится TALKED_TO_FIRST
	
	is_talking = false
	is_active = true
	disappear_timer.start(10.0)   # через 10 секунд исчезнет

func _on_disappear():
	queue_free()
