extends Pickup


func contact_body(body: Node) -> void:
	if body is Player:
		body.heal(1)
	.contact_body(body)
