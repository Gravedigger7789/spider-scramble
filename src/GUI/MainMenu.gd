extends Control


func _ready():
	get_tree().paused = true


func _input(event):
	if (
		event.is_action_pressed("attack")
		or event.is_action_pressed("jump")
		or event.is_action_pressed("pause")
	):
		get_tree().set_input_as_handled()
		hide()
		set_process_input(false)
		get_tree().paused = false
