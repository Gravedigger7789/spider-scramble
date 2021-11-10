extends Area2D
class_name Obstacle

const SPEED = 400.0
onready var sprite: Sprite = $Sprite
onready var size = Vector2(sprite.texture.get_width(), sprite.texture.get_height())


func _physics_process(delta: float) -> void:
	position.x -= SPEED * delta

func _on_Obstacle_body_entered(body: Node) -> void:
	if body is Player:
		body.take_damage()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
