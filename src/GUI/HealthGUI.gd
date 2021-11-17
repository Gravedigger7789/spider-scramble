extends HBoxContainer


var heart_texture := preload("res://assets/collect/fly.png")

func _on_Player_max_health_changed(health):
	for child in get_children():
		remove_child(child)
		child.queue_free()
	for i in health:
		var heart_container := TextureRect.new()
		heart_container.texture = heart_texture
		add_child(heart_container)


func _on_Player_health_changed(health):
	for i in get_child_count():
		get_child(i).visible = health > i
