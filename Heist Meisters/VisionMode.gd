extends CanvasModulate

const DARK = Color("101353")
const NIGHTVISION = Color("0aac33")

func _ready():
    add_to_group("interface")
    color = DARK

func NightVision_mode():
    $NightVision_ON.play()
    color = NIGHTVISION
    inform_NPCS("NightVision_mode")

func Dark_mode():
    $NightVision_OFF.play()
    color = DARK
    inform_NPCS("Dark_mode")

func inform_NPCS(vision_mode):
    get_tree().call_group("NPC", vision_mode)