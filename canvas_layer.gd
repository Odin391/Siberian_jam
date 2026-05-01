extends CanvasLayer


@onready var coin_label: Label = $Panel/VBox/CoinLabel

func _ready():
	coin_label.text = "Монет: 0"
	Inventory.coins_changed.connect(_update)

func _update():
	coin_label.text = "Монет: " + str(Inventory.get_coins())
