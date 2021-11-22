extends Control

onready var continue_button: Button = $ColorRect/CenterContainer/VBoxContainer/ContinueButton


func _ready() -> void:
	hide()


func show() -> void:
	get_tree().paused = true
	continue_button.grab_focus()
	.show()


func _on_ContinueButton_pressed() -> void:
	get_tree().paused = false
	hide()


func _on_QuitButton_pressed() -> void:
	get_tree().quit()
