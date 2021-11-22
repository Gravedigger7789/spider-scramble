extends Area2D
class_name Obstacle

export var speed := 400.0

onready var sprite: Sprite = $Sprite
onready var size := Vector2(sprite.texture.get_width(), sprite.texture.get_height())
onready var audio_player : AudioStreamPlayer = $AudioStreamPlayer


func _physics_process(delta: float) -> void:
	position.x -= speed * delta * Difficulty.speed_modifier


func _on_Obstacle_body_entered(body: Node) -> void:
	if body is Player:
		body.take_damage()
		play_contact_sound()


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()


func play_contact_sound() -> void:
	set_deferred("monitorable", false)
	set_deferred("monitoring", false)
	visible = false
	var connected = audio_player.connect("finished", self, "queue_free")
	if connected != OK:
		push_warning("Could not connect contact sound finished")
	audio_player.play()
