extends Control

export(AudioStreamSample) var pause_sound: AudioStreamSample
export(AudioStreamSample) var resume_sound: AudioStreamSample

onready var continue_button: Button = $ColorRect/CenterContainer/VBoxContainer/ContinueButton
onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


func _ready() -> void:
	hide()


func show() -> void:
	audio_stream_player.stream = pause_sound
	audio_stream_player.play()
	get_tree().paused = true
	continue_button.grab_focus()
	.show()


func _on_ContinueButton_pressed() -> void:
	audio_stream_player.stream = resume_sound
	audio_stream_player.play()
	get_tree().paused = false
	hide()


func _on_QuitButton_pressed() -> void:
	get_tree().quit()
