extends Obstacle


func _on_Obstacle_body_entered(body: Node) -> void:
	if body is Player:
		body.heal(1)
		play_contact_sound()
