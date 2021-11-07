extends KinematicBody2D
class_name Player

const JUMP_SPEED := 380
const TERMINAL_VELOCITY := 500

var velocity := Vector2()

onready var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
onready var weapon: Weapon = $Weapon

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	velocity.y = min(TERMINAL_VELOCITY, velocity.y)
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -JUMP_SPEED
	
	if Input.is_action_just_pressed("attack"):
		weapon.attack()
