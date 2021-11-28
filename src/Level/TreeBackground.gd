extends ParallaxBackground


func _process(delta: float) -> void:
	var offset: Vector2 = get_scroll_offset() + Difficulty.velocity * delta
	set_scroll_offset(offset)
