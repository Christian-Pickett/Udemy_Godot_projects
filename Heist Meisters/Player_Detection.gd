extends "res://Scripts/Character.gd"

const FOV_TOLERANCE = 20
const MAX_DETECTION_RANGE = 320

onready var Player = Global.Player 

func _ready():
    add_to_group("NPC")

func _process(delta):
	if Player_is_in_FOV_TOLERANCE() and Player_is_in_LOS():
		$Torch.color = "ff0000" #red
	else:
		$Torch.color = "ffffff" #white

func Player_is_in_FOV_TOLERANCE():
	var NPC_facing_direction = Vector2(1,0).rotated(global_rotation)
	var direction_to_Player = (Player.position - global_position).normalized()

	if abs(direction_to_Player.angle_to(NPC_facing_direction)) < deg2rad(FOV_TOLERANCE):
		return true
	else:
		return false

func Player_is_in_LOS():
	var space = get_world_2d().direct_space_state
	var LOS_obstacle = space.intersect_ray(global_position, Player.global_position, [self], collision_mask)
	var distance_to_Player = Player.global_position.distance_to(global_position)
	var player_is_in_range = distance_to_Player < MAX_DETECTION_RANGE

	if LOS_obstacle and LOS_obstacle.collider == Player and player_is_in_range:
		return true
	else:
		return false

func NightVision_mode():
	$Torch.enabled = false

func Dark_mode():
	$Torch.enabled = true