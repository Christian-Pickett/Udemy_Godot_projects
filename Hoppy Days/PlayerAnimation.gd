extends AnimatedSprite

func update(motion, isHurt):

	flip_h = false

	if isHurt:
		play("hurt")
	elif motion.y < 0:
		play("jump")
	elif motion.x > 0:
		play("run")
	elif motion.x < 0:
		play("run")
		flip_h = true
	else:
		play("idle")