extends Area2D
class_name Projectile

const SPEED := 500.0
const ENEMY_LAYER := 2

func _physics_process(delta: float) -> void:
	position.x += SPEED * delta

func _on_Projectile_body_entered(body: Node) -> void:
	if body.collision_layer == ENEMY_LAYER:
		body.queue_free()
	queue_free()

func _on_Expiration_timeout():
	queue_free()
