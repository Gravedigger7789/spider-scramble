extends Control


func _ready():
	set_process_input(false)

func show() -> void:
	get_tree().paused = true
	set_process_input(true)
	.show()

func _input(event: InputEvent) -> void:
	if (
		event.is_action_pressed("attack")
		or event.is_action_pressed("jump")
		or event.is_action_pressed("pause")
	):
		get_tree().set_input_as_handled()
		hide()
		set_process_input(false)
		get_tree().paused = false
		get_tree().reload_current_scene()
