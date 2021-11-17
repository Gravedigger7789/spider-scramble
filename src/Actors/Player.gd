extends KinematicBody2D
class_name Player

const JUMP_SPEED := 550.0
const TERMINAL_VELOCITY := 550.0
const MAX_HEALTH := 3

var velocity := Vector2()
var coins := 0

export var can_attack := true

onready var health := MAX_HEALTH
onready var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
onready var weapon: Weapon = $Weapon
onready var animation_player: AnimationNodeStateMachinePlayback = $AnimationTree.get(
	"parameters/playback"
)


func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	velocity.y = min(TERMINAL_VELOCITY, velocity.y)
	velocity = move_and_slide(velocity, Vector2.UP)

	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -JUMP_SPEED
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= 0.6

	if can_attack && Input.is_action_just_pressed("attack"):
		var has_attacked = weapon.attack()
		if has_attacked:
			animation_player.travel("walk_attack")


func take_damage() -> void:
	animation_player.travel("damage")
	heal(-1)


func collect_coin(count: int) -> void:
	coins += count
	print(coins)


func heal(count: int) -> void:
	health = int(clamp(health + count, 0, MAX_HEALTH))
	print(health)
	if health <= 0:
		queue_free()
