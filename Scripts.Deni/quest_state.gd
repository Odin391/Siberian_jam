extends Node

enum QuestStage {
	NOT_STARTED,
	TALKED_TO_FIRST,
	RECEIVED_QUEST,
	QUEST_COMPLETED,
	BOSS_PATH_OPENED
}

# Создаём константы для удобного доступа
const NOT_STARTED = QuestStage.NOT_STARTED
const TALKED_TO_FIRST = QuestStage.TALKED_TO_FIRST
const RECEIVED_QUEST = QuestStage.RECEIVED_QUEST
const QUEST_COMPLETED = QuestStage.QUEST_COMPLETED
const BOSS_PATH_OPENED = QuestStage.BOSS_PATH_OPENED

var stage = NOT_STARTED

func advance_to_next_stage():
	stage = stage + 1
	print("Квест перешёл на стадию: ", stage)

func reset():
	stage = NOT_STARTED
