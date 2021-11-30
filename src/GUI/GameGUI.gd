extends Control
class_name GameGUI

export(NodePath) var player_path

onready var player: Player = get_node(player_path)
onready var health_gui = $HBoxContainer/HealthGUI
onready var ammo_gui = $HBoxContainer/AmmoGUI
onready var score_gui = $HBoxContainer/ScoreGUI
onready var pause_menu = $CanvasLayer/PauseMenu
onready var game_over_menu = $CanvasLayer/GameOverMenu


func _ready() -> void:
	var connected := player.connect(
		"max_health_changed", health_gui, "_on_Player_max_health_changed"
	)
	if connected != OK:
		push_warning("Could not connect player max health changed")
	connected = player.connect("health_changed", health_gui, "_on_Player_health_changed")
	if connected != OK:
		push_warning("Could not connect player health changed")
	connected = player.connect("health_depleted", self, "_on_Player_health_depleted")
	if connected != OK:
		push_warning("Could not connect player health depleted")
	connected = player.connect("max_ammo_changed", ammo_gui, "_on_Player_max_ammo_changed")
	if connected != OK:
		push_warning("Could not connect player max ammo changed")
	connected = player.connect("ammo_changed", ammo_gui, "_on_Player_ammo_changed")
	if connected != OK:
		push_warning("Could not connect player ammo changed")
	connected = player.connect("coins_changed", score_gui, "_on_Player_coins_changed")
	if connected != OK:
		push_warning("Could not connect player coins changed")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		pause_menu.show()
		get_tree().set_input_as_handled()


func _on_Player_health_depleted() -> void:
	score_gui.save_high_score()
	game_over_menu.show()


func _process(_delta: float) -> void:
	game_over_menu.time = score_gui.time
	game_over_menu.score = score_gui.score_adjusted
