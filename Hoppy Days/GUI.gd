extends CanvasLayer

func _ready():
	Global.GUI = self

func update_GUI(coins, lives):
	$Banner/HBoxContainer/LifeCount.text = str(lives)
	$Banner/HBoxContainer/CoinCount.text = str(coins)

func animate(animation):
	$AnimationPlayer.play(animation)
