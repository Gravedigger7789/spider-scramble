extends KinematicBody2D

const JUMP_SPEED := 550.0
const TERMINAL_VELOCITY := 550.0
const MAX_HEALTH := 3

var has_jumped := false

onready var velocity := Difficulty.velocity
export(float, 0, 30) var min_jump_time := 0.25
export(float, 0, 30) var max_jump_time := 0.75

onready var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
onready var jump_timer: Timer = $JumpTimer
onready var sprite: Sprite = $Sprite
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var size := Vector2(sprite.texture.get_width(), sprite.texture.get_height())
onready var player_detector: RayCast2D = $PlayerDetector
onready var screen_detector: RayCast2D = $ScreenDetector


func _ready() -> void:
	randomize()
	randomize_jump_time()


func randomize_jump_time() -> void:
	var random_jump_time := rand_range(min_jump_time, max_jump_time) * Difficulty.spawn_modifier
	jump_timer.start(random_jump_time)


func jump() -> void:
	if is_on_floor() && !has_jumped:
		animation_player.play("jump")
		velocity.y = -JUMP_SPEED
		has_jumped = true


func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	velocity.y = min(TERMINAL_VELOCITY, velocity.y)
	velocity.x = Difficulty.velocity.x
	velocity = move_and_slide(velocity, Vector2.UP)
	if velocity.y > 0:
		animation_player.play("fall")
	if is_on_floor():
		animation_player.play("RESET")
	if is_on_floor() && player_detector.is_colliding() && !has_jumped:
		jump()
	# Check if birb is within the game bounds and reset jump
	# This is to prevent wide screen users from cheesing the birb
	if screen_detector.is_colliding():
		has_jumped = false
		screen_detector.enabled = false


func _on_JumpTimer_timeout() -> void:
	jump()
	randomize_jump_time()


func _on_Area2D_body_entered(body: Node):
	if body is Player:
		queue_free()
		body.take_damage()
