extends AnimatedSprite

var taken = false

func _on_Area2D_body_entered(body):
	if taken == false: 
		taken = true
		Global.GameState.coin_up()
		$AnimationPlayer.play("die")
		$Coin_SFX.play()

		
	#this is called in the AnimationPlayer @ the end
func die():
	queue_free()
