extends "res://Scripts/Character.gd"

var motion = Vector2()
enum vision_mode {DARK, NIGHTVISION}

func _process(delta):
	update_motion(delta)
	move_and_slide(motion)

func _ready():
	Global.Player = self
	vision_mode = DARK

func update_motion(delta):
	look_at(get_global_mouse_position())

	#horizontal movement
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		if not (Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down")):
			motion.x = clamp((motion.x + SPEED), 0, MAX_SPEED)
		else:
			motion.x = clamp((motion.x + SPEED), 0, MAX_SPEED * (1/sqrt(2)))

	elif Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		if not (Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down")):
			motion.x = clamp((motion.x - SPEED), -MAX_SPEED, 0)
		else:
			motion.x = clamp((motion.x - SPEED), -MAX_SPEED * (1/sqrt(2)), 0)

	else:
		motion.x = lerp(motion.x, 0, FRICTION)
	
	#vertical movement
	if Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_down"):
		if not (Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")):
			motion.y = clamp((motion.y - SPEED), -MAX_SPEED, 0)
		else:
			motion.y = clamp((motion.y - SPEED), -MAX_SPEED * (1/sqrt(2)), 0)

	elif Input.is_action_pressed("ui_down") and not Input.is_action_pressed("ui_up"):
		if not (Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")):
			motion.y = clamp((motion.y + SPEED), 0, MAX_SPEED)
		else:
			motion.y = clamp((motion.y + SPEED), 0, MAX_SPEED * (1/sqrt(2)))
	else:
		motion.y = lerp(motion.y, 0, FRICTION)

func _input(event):
	if Input.is_action_just_pressed("ui_vision_mode_change"):
		if $VisionModeTimer.is_stopped():
			cycle_vision_mode()
			$VisionModeTimer.start()

func cycle_vision_mode():
	if vision_mode == DARK:
		get_tree().call_group("interface", "NightVision_mode")
		vision_mode = NIGHTVISION
	elif vision_mode == NIGHTVISION:
		get_tree().call_group("interface", "Dark_mode")
		vision_mode = DARK
