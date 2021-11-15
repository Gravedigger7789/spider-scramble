extends KinematicBody2D

const JUMP_SPEED := 550.0
const TERMINAL_VELOCITY := 550.0
const MAX_HEALTH := 3

export var velocity := Vector2(-400, 0)
export(float, 0, 30) var min_jump_time := 0.5
export(float, 0, 30) var max_jump_time := 1.5

onready var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
onready var jump_timer: Timer = $JumpTimer
onready var sprite: Sprite = $Sprite
onready var size := Vector2(sprite.texture.get_width(), sprite.texture.get_height())


func _ready() -> void:
	randomize()
	randomize_jump_time()


func randomize_jump_time() -> void:
	var random_jump_time := rand_range(min_jump_time, max_jump_time)
	jump_timer.start(random_jump_time)


func jump() -> void:
	if is_on_floor():
		velocity.y = -JUMP_SPEED


func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	velocity.y = min(TERMINAL_VELOCITY, velocity.y)
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_JumpTimer_timeout() -> void:
	jump()
	randomize_jump_time()


func _on_Area2D_body_entered(body):
	if body is Player:
		queue_free()
		body.take_damage()
