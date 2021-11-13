extends ParallaxBackground


export var velocity: Vector2 = Vector2( -400, 0 );
 
 
func _process(delta: float) -> void:
	var offset: Vector2 = get_scroll_offset() + velocity * delta
	set_scroll_offset(offset)
