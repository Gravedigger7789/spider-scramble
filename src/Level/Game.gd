extends Node


export(Array, AudioStreamSample) var loop_sounds: Array

onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


func _ready() -> void:
	randomize()

func _on_AudioStreamPlayer_finished() -> void:
	audio_stream_player.stream = loop_sounds[randi() % loop_sounds.size()]
	audio_stream_player.play()
