extends Popup

var combination = [4,1,5]
var guess = []

onready var display = $VSplitContainer/DisplayContainer/Display

func _ready():
    connect_buttons()
    reset_lock()

func connect_buttons():
    for child in $VSplitContainer/ButtonContainer/ButtonGrid.get_children():
        if child is Button:
            child.connect("pressed", self, "_on_Button_pressed", [child.text])

func _on_Button_pressed(button):
    if button == "OK":
        check_guess()
    else:
        enter(int(button))

func check_guess():
    if guess == combination:
        $VSplitContainer/ButtonContainer/ButtonGrid/Light.texture = load("res://GFX/Interface/PNG/dotGreen.png")
        $Timer.start()
    else:
        reset_lock()

func enter(button):
    guess.append(button)
    update_display()

func reset_lock():
    display.clear()
    guess.clear()
    $VSplitContainer/ButtonContainer/ButtonGrid/Light.texture = load("res://GFX/Interface/PNG/dotRed.png")

func update_display():
    display.bbcode_text = "[center]" + PoolStringArray(guess).join("") + "[/center]"
    if guess.size() == combination.size():
        check_guess()

func _on_Timer_timeout():
    hide()
    reset_lock()