extends Area2D
class_name Pickup

# Hack to use pickup object on splash screen without it moving
export var pause := false

onready var sprite: Sprite = $Sprite
onready var size := Vector2(sprite.texture.get_width(), sprite.texture.get_height())
onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer


func _ready():
	if pause:
		set_physics_process(false)


func _physics_process(delta: float) -> void:
	position += Difficulty.velocity * delta


func _on_Pickup_body_entered(body: Node) -> void:
	contact_body(body)


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()


func contact_body(body: Node) -> void:
	if body is Player:
		play_contact_sound()


func play_contact_sound() -> void:
	set_deferred("monitorable", false)
	set_deferred("monitoring", false)
	visible = false
	var connected = audio_player.connect("finished", self, "queue_free")
	if connected != OK:
		push_warning("Could not connect contact sound finished")
	audio_player.play()
