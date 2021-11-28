extends Area2D
class_name Projectile

const SPEED := 500.0

onready var hit_sound: AudioStreamPlayer = $HitSound


func _physics_process(delta: float) -> void:
	position.x += SPEED * delta


func _on_Projectile_body_entered(body: Node) -> void:
	hit()
	if body.has_method("damage"):
		body.damage()


func _on_Expiration_timeout():
	queue_free()


func hit() -> void:
	set_deferred("monitorable", false)
	set_deferred("monitoring", false)
	visible = false
	var connected = hit_sound.connect("finished", self, "queue_free")
	if connected != OK:
		push_warning("Could not connect hit sound finished")
	hit_sound.play()
