extends Area2D
class_name Obstacle

export var speed := 400.0

onready var sprite: Sprite = $Sprite
onready var size := Vector2(sprite.texture.get_width(), sprite.texture.get_height())


func _physics_process(delta: float) -> void:
	position.x -= speed * delta * Difficulty.speed_modifier


func _on_Obstacle_body_entered(body: Node) -> void:
	if body is Player:
		queue_free()
		body.take_damage()


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
