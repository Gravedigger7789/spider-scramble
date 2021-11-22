extends KinematicBody2D
class_name Player

signal max_health_changed(health)
signal health_changed(health)
signal health_depleted
signal max_ammo_changed(ammo)
signal ammo_changed(ammo)
signal coins_changed(coins)

const JUMP_SPEED := 550.0
const TERMINAL_VELOCITY := 550.0

var max_health: int setget set_max_health
var health: int setget set_health
var max_ammo: int setget set_max_ammo
var ammo: int setget set_ammo
var velocity := Vector2()
var coins := 0 setget set_coins

export var can_attack := true setget , get_can_attack

onready var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
onready var weapon: Weapon = $Weapon
onready var animation_player: AnimationNodeStateMachinePlayback = $AnimationTree.get(
	"parameters/playback"
)
onready var jump_sound: AudioStreamPlayer = $JumpSound
onready var no_ammo_attack_sound: AudioStreamPlayer = $NoAmmoAttackSound


func _ready() -> void:
	self.max_health = 3
	self.max_ammo = 5


func set_max_health(value: int) -> void:
	max_health = int(max(1, value))
	emit_signal("max_health_changed", max_health)
	self.health = max_health


func set_health(value: int) -> void:
	if health != value:
		health = value
		emit_signal("health_changed", value)
	if health <= 0:
		queue_free()
		emit_signal("health_depleted")


func set_max_ammo(value: int) -> void:
	max_ammo = int(max(1, value))
	emit_signal("max_ammo_changed", max_ammo)
	self.ammo = max_ammo


func set_ammo(value: int) -> void:
	if ammo != value:
		ammo = value
		emit_signal("ammo_changed", ammo)


func set_coins(value: int) -> void:
	if coins != value:
		coins = value
		emit_signal("coins_changed", coins)


func get_can_attack() -> bool:
	return can_attack and ammo > 0


func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	velocity.y = min(TERMINAL_VELOCITY, velocity.y)
	velocity = move_and_slide(velocity, Vector2.UP)

	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -JUMP_SPEED
		jump_sound.play()
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= 0.6


func _input(event: InputEvent):
	if self.can_attack && event.is_action_pressed("attack"):
		get_tree().set_input_as_handled()
		var has_attacked = weapon.attack()
		if has_attacked:
			animation_player.travel("walk_attack")
			self.ammo = int(max(ammo - 1, 0))
	elif can_attack && ammo <= 0 && !no_ammo_attack_sound.playing:
		no_ammo_attack_sound.play()


func take_damage() -> void:
	animation_player.travel("damage")
	heal(-1)


func collect_coin(value: int) -> void:
	self.coins += value


func heal(value: int) -> void:
	if value < 0:
		self.health = int(clamp(health + value, 0, max_health))
	elif health < max_health:
		self.health = int(clamp(health + value, 0, max_health))
	else:
		self.ammo = int(clamp(ammo + value, 0, max_ammo))
