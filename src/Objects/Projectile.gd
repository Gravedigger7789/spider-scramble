class_name Projectile
extends Area2D

const SPEED := 500.0

func _physics_process(delta) -> void:
	position += transform.x * SPEED * delta

func _on_Projectile_body_entered(body) -> void:
	if body.collision_layer == 2:
		body.queue_free()	
	queue_free()

func _on_Expiration_timeout():
	queue_free()
