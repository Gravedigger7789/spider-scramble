extends HBoxContainer

onready var label: Label = $CenterContainer/Label
var score := 0.0 setget set_score
var coins := 0


func set_score(value: float) -> void:
	if score != value:
		score = value
		label.text = "%.0f" % (score + coins)


func _on_Player_coins_changed(value: int) -> void:
	coins = value


func _process(delta: float) -> void:
	self.score += delta * Difficulty.speed_modifier
