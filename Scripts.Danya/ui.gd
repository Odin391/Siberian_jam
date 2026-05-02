extends Label


func _ready():
	self.text = "❤️ " + str(GlobalInfo.health) + "/" + str(10)
