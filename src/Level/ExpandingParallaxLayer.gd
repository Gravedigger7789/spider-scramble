extends ParallaxLayer
class_name ExpandingParallaxLayer


func _ready() -> void:
	expand_children()
	var connected := get_tree().root.connect("size_changed", self, "_on_viewport_size_changed")
	if connected != OK:
		push_warning("Could not connect viewport size changed")


func _on_viewport_size_changed() -> void:
	expand_children()


func expand_children() -> void:
	var current_size := get_viewport().size
	var largest_mirror := 0.0
	for child in get_children():
		if child is Sprite:
			var sprite_child: Sprite = child
			var sprite_child_size := sprite_child.texture.get_size()
			# Get the total sprites that will fit on screen size rounded up
			var sprite_count := Vector2(int(ceil(current_size.x / sprite_child_size.x)), 1)
			var wanted_size := sprite_count * sprite_child_size
			sprite_child.region_enabled = true
			sprite_child.region_rect.size = wanted_size
			largest_mirror = max(largest_mirror, wanted_size.x)
		elif child is TextureRect:
			var texture_child: TextureRect = child
			# Get the total textures that will fit on screen size rounded up
			var texture_count := Vector2(int(ceil(current_size.x / texture_child.rect_size.x)), 1)
			var wanted_size := texture_count * texture_child.rect_size
			texture_child.stretch_mode = TextureRect.STRETCH_TILE
			texture_child.rect_size = wanted_size
			largest_mirror = max(largest_mirror, wanted_size.x)
	# Set the mirror to the largest sprite/texture found
	motion_mirroring.x = largest_mirror
