extends Control

var score := 0.0 setget set_score
var time := 0.0 setget set_time

onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
onready var time_value: Label = $Background/ColorRect/CenterContainer/VBoxContainer/TimeContainer/PanelContainer/TimeValue
onready var score_value: Label = $Background/ColorRect/CenterContainer/VBoxContainer/ScoreContainer/PanelContainer/ScoreValue


func _ready():
	set_process_input(false)


func show() -> void:
	audio_stream_player.play()
	get_tree().paused = true
	set_process_input(true)
	.show()


func _input(event: InputEvent) -> void:
	if (
		event.is_action_pressed("attack")
		or event.is_action_pressed("jump")
		or event.is_action_pressed("pause")
		or event is InputEventMouseButton
	):
		get_tree().set_input_as_handled()
		hide()
		set_process_input(false)
		get_tree().paused = false
		var connected := get_tree().reload_current_scene()
		if connected != OK:
			push_error("Could not reload scene")


func set_time(value: float) -> void:
	if time != value:
		time = value
		time_value.text = "%.0f" % (time)


func set_score(value: float) -> void:
	if score != value:
		score = value
		score_value.text = "%.0f" % (score)
