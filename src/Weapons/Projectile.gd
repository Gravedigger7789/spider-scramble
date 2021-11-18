extends Area2D
class_name Projectile

const SPEED := 500.0

onready var hit_sound: AudioStreamPlayer2D = $HitSound


func _physics_process(delta: float) -> void:
	position.x += SPEED * delta


func _on_Projectile_body_entered(body: Node) -> void:
	set_deferred("monitorable", false)
	set_deferred("monitoring", false)
	visible = false
	hit_sound.connect("finished", self, "queue_free")
	hit_sound.play()
	body.queue_free()


func _on_Expiration_timeout():
	queue_free()
