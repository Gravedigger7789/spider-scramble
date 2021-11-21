extends Node


var speed_modifier = 1.0
var difficulty_increase_seconds := 5.0
var elapsed_time := 0.0

func _process(delta):
	elapsed_time += delta
	if elapsed_time >= difficulty_increase_seconds:
		speed_modifier += 0.1
		elapsed_time = 0
