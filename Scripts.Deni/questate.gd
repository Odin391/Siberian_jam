extends Node

enum QuestStage {
	NOT_STARTED,        # ещё не говорил с первым старцем
	TALKED_TO_FIRST,    # первый старец отправил к реке
	RECEIVED_QUEST,     # второй старец дал задание (ждать ингредиенты)
	QUEST_COMPLETED,    # ингредиенты принесены
	BOSS_PATH_OPENED    # отправлен к босу
}

var stage = QuestStage.NOT_STARTED

func advance_to_next_stage():
	stage = stage + 1
	print("Квест перешёл на стадию: ", stage)

func reset():
	stage = QuestStage.NOT_STARTED
