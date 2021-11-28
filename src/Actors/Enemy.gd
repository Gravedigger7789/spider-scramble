extends KinematicBody2D
class_name Enemy

signal defeated

const TERMINAL_VELOCITY := 550.0

onready var velocity := Difficulty.velocity
onready var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
onready var sprite: Sprite = $Sprite
onready var size := Vector2(sprite.texture.get_width(), sprite.texture.get_height())


func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	velocity.y = min(TERMINAL_VELOCITY, velocity.y)
	velocity.x = Difficulty.velocity.x
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_Area2D_body_entered(body: Node) -> void:
	if body is Player:
		queue_free()
		body.take_damage()


func damage() -> void:
	queue_free()
	emit_signal("defeated")
