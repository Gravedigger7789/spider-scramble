extends KinematicBody2D

const JUMP_SPEED := 550.0
const TERMINAL_VELOCITY := 550.0
const MAX_HEALTH := 3
const JUMP_DETECTION_DISTANCE := 100

onready var velocity := Difficulty.velocity

onready var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
onready var sprite: Sprite = $Sprite
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var size := Vector2(sprite.texture.get_width(), sprite.texture.get_height())
onready var jump_detector: Area2D = $JumpDetector
onready var jump_detector_collision: CollisionShape2D = $JumpDetector/CollisionShape2D


func jump() -> void:
	if is_on_floor():
		animation_player.play("jump")
		velocity.y = -JUMP_SPEED


func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	velocity.y = min(TERMINAL_VELOCITY, velocity.y)
	velocity.x = Difficulty.velocity.x
	velocity = move_and_slide(velocity, Vector2.UP)
	if velocity.y > 0:
		animation_player.play("fall")
	if is_on_floor():
		animation_player.play("RESET")
	jump_detector_collision.shape.extents.x = JUMP_DETECTION_DISTANCE * Difficulty.speed_modifier
	jump_detector_collision.position.x = -jump_detector_collision.shape.extents.x


func _on_Area2D_body_entered(body: Node):
	if body is Player:
		queue_free()
		body.take_damage()


func _on_JumpDetector_body_entered(body: Node):
	if body is Player:
		jump()
		jump_detector.set_deferred("monitorable", false)
		jump_detector.set_deferred("monitoring", false)
