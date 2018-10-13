
extends Node2D

export var starting_lives = 3
export var coins_per_life = 18

onready var GUI = Global.GUI

var lives
var coins = 0

func _ready():
	Global.GameState = self
	lives = starting_lives
	update_GUI()

func update_GUI():
	GUI.update_GUI(coins, lives)

func animate_GUI(animation):
	GUI.animate(animation)


func hurt():
	lives -= 1
	Global.Player.hurt()
	update_GUI()
	animate_GUI("Hurt")
	if lives < 0:
		end_game()

func coin_up():
	coins += 1
	update_GUI()
	animate_GUI("CoinPulse")
	
	if coins % coins_per_life == 0:
		life_up()

func life_up():
	lives += 1
	update_GUI()
	animate_GUI("LifePulse")

func end_game():
	get_tree().change_scene("res://Scenes/Levels/GameOver.tscn")

func win_game():
	get_tree().change_scene("res://Scenes/Levels/Victory.tscn")


func _on_Portal_body_entered(body):
	win_game()