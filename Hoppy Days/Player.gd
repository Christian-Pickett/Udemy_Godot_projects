extends KinematicBody2D

const SPEED = 750
const JUMP_SPEED = -1200
const JUMP_BOOST = 2
const GRAVITY = 3600
const UP = Vector2(0, -1)

export var world_limit = 3000
var motion = Vector2()
var isHurt = false

func _ready():
	Global.Player = self

func _physics_process(delta):
	update_motion(delta)

func _process(delta):
	$AnimatedSprite.update(motion, isHurt)
			
func update_motion(delta):
	fall(delta)
	run()
	jump()
	move_and_slide(motion, UP)
			
func fall(delta):
	if motion.y > 0 and is_on_floor() or is_on_ceiling():
		motion.y = 0
		isHurt = false
	else:
		motion.y += GRAVITY * delta

	if position.y > world_limit:
		 Global.GameState.end_game()
		 
	motion.y = clamp(motion.y, (JUMP_SPEED * JUMP_BOOST), 1500)

func run():
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		motion.x = SPEED 
		
	elif Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		motion.x = -SPEED 

	else:
		motion.x = 0

func hurt():
	isHurt = true
	if motion.y >= 0:
		motion.y = JUMP_SPEED
	else:
		motion.y = 0
	Global.pain_sfx.play()
	
func jump():
	if Input.is_action_pressed("ui_up") and is_on_floor():
		motion.y = JUMP_SPEED
		Global.jump_sfx.play()

func boost():
	motion.y = JUMP_SPEED * JUMP_BOOST

