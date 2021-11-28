extends Enemy

const JUMP_SPEED := 550.0
const JUMP_DETECTION_DISTANCE := 100

onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var jump_detector: Area2D = $JumpDetector
onready var jump_detector_collision: CollisionShape2D = $JumpDetector/CollisionShape2D


func jump() -> void:
	animation_player.play("jump")
	velocity.y = -JUMP_SPEED


func _physics_process(_delta: float) -> void:
	if velocity.y > 0:
		animation_player.play("fall")
	if velocity.y > 0 && is_on_floor():
		animation_player.play("RESET")
	jump_detector_collision.shape.extents.x = JUMP_DETECTION_DISTANCE * Difficulty.speed_modifier
	jump_detector_collision.position.x = -jump_detector_collision.shape.extents.x


func _on_JumpDetector_body_entered(body: Node):
	if body is Player:
		jump()
		jump_detector.set_deferred("monitorable", false)
		jump_detector.set_deferred("monitoring", false)
