extends HBoxContainer


var ammo_texture := preload("res://assets/player/acid_shot_2.png")

func _on_Player_max_ammo_changed(ammo):
	for child in get_children():
		remove_child(child)
		child.queue_free()
	for i in ammo:
		var ammo_container := TextureRect.new()
		ammo_container.texture = ammo_texture
		# ammo_container.rect_rotation = -90
		# ammo_container.rect_position.y = ammo_container.texture.get_width()
		add_child(ammo_container)


func _on_Player_ammo_changed(ammo):
	for i in get_child_count():
		get_child(i).visible = ammo > i
