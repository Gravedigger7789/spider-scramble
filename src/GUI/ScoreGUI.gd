extends GridContainer

onready var score_label: Label = $ScorePanel/Score
onready var high_score_label: Label = $HighScorePanel/HighScore
var high_score_data := {}
var high_score := 0.0
var high_time := 0.0
var high_score_adjusted := 0.0
var score := 0.0 setget set_score
var time := 0.0
var coins := 0
var score_adjusted := 0.0
var enemies_deated := 0
var enemy_value := 5.0
var high_score_path = "user://highscore.json"


func _enter_tree() -> void:
	var file := File.new()
	if file.file_exists(high_score_path):
		var open = file.open(high_score_path, File.READ)
		if open == OK:
			while file.get_position() < file.get_len():
				high_score_data = parse_json(file.get_line())
			file.close()
		for key in high_score_data:
			set(key, high_score_data[key])


func set_score(value: float) -> void:
	if score != value:
		score = value
		score_adjusted = score + coins + (enemies_deated * enemy_value)
		score_label.text = "%.0f" % (score_adjusted)
		high_score = max(high_score, score)
		high_time = max(high_time, time)
		high_score_adjusted = max(high_score_adjusted, score_adjusted)
		high_score_label.text = "%.0f" % (high_score_adjusted)


func _on_Player_coins_changed(value: int) -> void:
	coins = value


func _on_Enemy_defeated() -> void:
	enemies_deated += 1


func _process(delta: float) -> void:
	time += delta
	self.score += delta * Difficulty.speed_modifier
	# Save high score every 5 seconds in case of accidental closure
	if int(time) % 5 == 0:
		save_high_score()


func save_high_score() -> void:
	var file = File.new()
	file.open(high_score_path, File.WRITE)
	var data = {
		"high_score": high_score,
		"high_time": high_time,
		"high_score_adjusted": high_score_adjusted,
	}
	file.store_line(to_json(data))
	file.close()
