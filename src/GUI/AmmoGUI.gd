extends PanelContainer

var ammo_texture := preload("res://assets/player/acid_shot_2.png")
var ammo_container_node := "AmmoContainer"

onready var ammo_holder: HBoxContainer = $AmmoHolder


func _on_Player_max_ammo_changed(ammo: int) -> void:
	for child in ammo_holder.get_children():
		ammo_holder.remove_child(child)
		child.queue_free()
	for i in ammo:
		var ammo_container := TextureRect.new()
		ammo_container.name = ammo_container_node
		ammo_container.texture = ammo_texture
		var center_container := CenterContainer.new()
		center_container.add_child(ammo_container)
		ammo_holder.add_child(center_container)


func _on_Player_ammo_changed(ammo: int) -> void:
	for i in ammo_holder.get_child_count():
		var ammo_container: TextureRect = ammo_holder.get_child(i).get_node(ammo_container_node)
		ammo_container.modulate = Color(1, 1, 1, 1) if ammo > i else Color(0.1, 0.1, 0.1, 0.5)
