extends Node

var coins = 0   # количество монет

signal coins_changed

func add_coin(amount=1):
	coins += amount
	print("Монет в инвентаре: ", coins)
	coins_changed.emit()

func get_coins():
	return coins
