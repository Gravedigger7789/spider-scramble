extends Pickup


func contact_body(body: Node) -> void:
	if body is Player:
		body.collect_coin(5)
	.contact_body(body)
