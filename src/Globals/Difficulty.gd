extends Node

const ORIGINAL_VELOCITY := Vector2(-400, 0)
const SPEED_MODIFIER_MAX := 3.0
const SPAWN_MODIFIER_MIN := 0.25

var speed_modifier := 1.0
var spawn_modifier := 1.5

var difficulty_increase_seconds := 5.0
var difficulty_speed_increase := 0.1
var difficulty_spawn_increase := 0.05
var elapsed_time := 0.0

onready var velocity := ORIGINAL_VELOCITY


func reset() -> void:
	speed_modifier = 1.0
	spawn_modifier = 2.0
	velocity = ORIGINAL_VELOCITY


func _process(delta: float) -> void:
	elapsed_time += delta
	if elapsed_time >= difficulty_increase_seconds:
		speed_modifier = min(speed_modifier + difficulty_speed_increase, SPEED_MODIFIER_MAX)
		spawn_modifier = max(spawn_modifier - difficulty_spawn_increase, SPAWN_MODIFIER_MIN)
		velocity = ORIGINAL_VELOCITY * speed_modifier
		elapsed_time = 0
