extends Node

export(PackedScene) var first_scene := preload("res://src/Level/Sandbox1.tscn")


func _input(event: InputEvent) -> void:
	if (
		event.is_action_pressed("attack")
		|| event.is_action_pressed("jump")
		|| event.is_action_pressed("pause")
	):
		get_tree().set_input_as_handled()
		get_tree().change_scene_to(first_scene)
