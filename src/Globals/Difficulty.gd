extends Node


var speed_modifier = 1.0
var difficulty_increase_seconds := 5.0
var difficulty_increase = 0.1
var elapsed_time := 0.0


func reset() -> void:
	speed_modifier = 1.0


func _process(delta: float) -> void:
	elapsed_time += delta
	if elapsed_time >= difficulty_increase_seconds:
		speed_modifier += difficulty_increase
		elapsed_time = 0
