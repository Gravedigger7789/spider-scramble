tool
extends Control

enum buttons {X = 1, Y = 2, B = 4, A = 8}
export (int, FLAGS, "X", "Y", "B", "A") var selected_buttons

onready var y_button: Button = $YButton
onready var x_button: Button = $XButton
onready var b_button: Button = $BButton
onready var a_button: Button = $AButton


func _ready() -> void:
	set_button_colors()


func _process(_delta) -> void:
	if Engine.editor_hint:
		set_button_colors()


func set_button_colors() -> void:
	if (buttons.A & selected_buttons):
		a_button.modulate = Color("#3cdb4e")
	else:
		a_button.modulate = Color(1,1,1)
	if (buttons.B & selected_buttons):
		b_button.modulate = Color("#d04242")
	else:
		b_button.modulate = Color(1,1,1)
	if (buttons.X & selected_buttons):
		x_button.modulate = Color("#40ccd0")
	else:
		x_button.modulate = Color(1,1,1)
	if (buttons.Y & selected_buttons):
		y_button.modulate = Color("#ecdb33")
	else:
		y_button.modulate = Color(1,1,1)
