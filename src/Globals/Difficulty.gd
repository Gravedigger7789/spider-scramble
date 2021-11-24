extends Node

const ORIGINAL_VELOCITY := Vector2(-400, 0)

var speed_modifier := 1.0
var difficulty_increase_seconds := 5.0
var difficulty_increase := 0.1
var elapsed_time := 0.0

onready var velocity := ORIGINAL_VELOCITY


func reset() -> void:
	speed_modifier = 1.0
	velocity = ORIGINAL_VELOCITY


func _process(delta: float) -> void:
	elapsed_time += delta
	if elapsed_time >= difficulty_increase_seconds:
		speed_modifier += difficulty_increase
		velocity = ORIGINAL_VELOCITY * speed_modifier
		elapsed_time = 0
