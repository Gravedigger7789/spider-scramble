extends Node


export (PackedScene) var first_scene := preload("res://src/Level/Sandbox1.tscn")


func _input(event: InputEvent) -> void:
	if (
		event.is_action_pressed("attack")
		or event.is_action_pressed("jump")
		or event.is_action_pressed("pause")
		or event is InputEventMouseButton
	):
		get_tree().set_input_as_handled()
		get_tree().change_scene_to(first_scene)
