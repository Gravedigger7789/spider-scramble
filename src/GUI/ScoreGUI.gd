extends HBoxContainer

onready var label: Label = $CenterContainer/Label
var score := 0.0 setget set_score


func set_score(value: float) -> void:
	if score != value:
		score = value
		label.text = "%.0f" % score


func _on_Player_coins_changed(coins):
	self.score += coins


func _process(delta):
	self.score += delta
