extends Control

onready var continue_button: Button = $ColorRect/CenterContainer/VBoxContainer/ContinueButton


func _ready():
	hide()


func show() -> void:
	get_tree().paused = true
	.show()
	continue_button.grab_focus()


func _on_ContinueButton_pressed():
	get_tree().paused = false
	hide()


func _on_QuitButton_pressed():
	get_tree().quit()
