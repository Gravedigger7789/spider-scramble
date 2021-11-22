extends Obstacle


func _on_Obstacle_body_entered(body: Node) -> void:
	if body is Player:
		body.collect_coin(5)
		play_contact_sound()
