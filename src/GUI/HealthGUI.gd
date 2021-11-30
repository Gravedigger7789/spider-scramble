extends PanelContainer

var heart_texture := preload("res://assets/collect/fly.png")
var heart_container_node := "HeartContainer"

onready var health_holder: HBoxContainer = $HealthHolder


func _on_Player_max_health_changed(health: int) -> void:
	for child in health_holder.get_children():
		health_holder.remove_child(child)
		child.queue_free()
	for i in health:
		var heart_container := TextureRect.new()
		heart_container.name = heart_container_node
		heart_container.texture = heart_texture
		var center_container := CenterContainer.new()
		center_container.add_child(heart_container)
		health_holder.add_child(center_container)


func _on_Player_health_changed(health: int) -> void:
	for i in health_holder.get_child_count():
		var heart_container: TextureRect = health_holder.get_child(i).get_node(heart_container_node)
		heart_container.modulate = Color(1, 1, 1, 1) if health > i else Color(0.1, 0.1, 0.1, 0.5)
