extends Sprite
class_name MovingSprite

onready var size := Vector2(texture.get_width(), texture.get_height())


func _ready():
	var visibility_notifier := VisibilityNotifier2D.new()
	visibility_notifier.rect = get_rect()
	var connected = visibility_notifier.connect("screen_exited", self, "queue_free")
	if connected != OK:
		push_warning("Could not connect sprite visibility notifier")
	add_child(visibility_notifier)


func _physics_process(delta: float) -> void:
	position += Difficulty.velocity * delta
