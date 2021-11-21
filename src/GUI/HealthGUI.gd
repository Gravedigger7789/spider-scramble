extends HBoxContainer

var heart_texture := preload("res://assets/collect/fly.png")
var heart_container_node = "HeartContainer"


func _on_Player_max_health_changed(health):
	for child in get_children():
		remove_child(child)
		child.queue_free()
	for i in health:
		var heart_container := TextureRect.new()
		heart_container.name = heart_container_node
		heart_container.texture = heart_texture
		var center_container := CenterContainer.new()
		center_container.add_child(heart_container)
		add_child(center_container)


func _on_Player_health_changed(health):
	for i in get_child_count():
		var heart_container: TextureRect = get_child(i).get_node(heart_container_node)
		heart_container.modulate = Color(1, 1, 1) if health > i else Color(0.1, 0.1, 0.1)
