extends KinematicBody2D
class_name Player

signal max_health_changed(health)
signal health_changed(health)
signal health_depleted()

const JUMP_SPEED := 550.0
const TERMINAL_VELOCITY := 550.0

var max_health : int setget set_max_health
var health : int setget set_health
var velocity := Vector2()
var coins := 0

export var can_attack := true

onready var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
onready var weapon: Weapon = $Weapon
onready var animation_player: AnimationNodeStateMachinePlayback = $AnimationTree.get(
	"parameters/playback"
)


func _ready() -> void:
	self.max_health = 3


func set_max_health(value: int) -> void:
	max_health = max(1, value)
	emit_signal("max_health_changed", max_health)
	self.health = max_health


func set_health(value: int) -> void:
	if health != value:
		health = value
		emit_signal("health_changed", value)
	if health <= 0:
		queue_free()
		emit_signal("health_depleted")


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


func collect_coin(value: int) -> void:
	coins += value
	print(coins)


func heal(value: int) -> void:
	self.health = int(clamp(health + value, 0, max_health))
