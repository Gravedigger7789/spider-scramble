extends HBoxContainer

onready var label: Label = $CenterContainer/Label
var score := 0.0 setget set_score
var time := 0.0
var coins := 0
var adjusted_score := 0.0
var enemies_deated := 0
var enemy_value := 5.0


func set_score(value: float) -> void:
	if score != value:
		score = value
		adjusted_score = score + coins + (enemies_deated * enemy_value)
		label.text = "%.0f" % (adjusted_score)


func _on_Player_coins_changed(value: int) -> void:
	coins = value


func _on_Enemy_defeated() -> void:
	enemies_deated += 1


func _process(delta: float) -> void:
	time += delta
	self.score += delta * Difficulty.speed_modifier
