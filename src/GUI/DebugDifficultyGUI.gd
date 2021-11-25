extends VBoxContainer


const LEVEL_TEXT = "Level: %-5.0f"
const SPEED_TEXT = "Speed Multiplier: %-5.2f"
const SPAWN_TEXT = "Spawn Multiplier: %-5.2f"
const ELAPSED_TEXT = "Time Since Last Level: %-5.2f"

onready var difficulty_level = $DifficultyLevel
onready var speed_multiplier = $SpeedMultiplier
onready var spawn_multiplier = $SpawnMultiplier
onready var elapsed_time = $ElapsedTime


func _process(_delta):
	difficulty_level.text = LEVEL_TEXT % Difficulty.difficulty_level
	speed_multiplier.text = SPEED_TEXT % Difficulty.speed_modifier
	spawn_multiplier.text = SPAWN_TEXT % Difficulty.spawn_modifier
	elapsed_time.text = ELAPSED_TEXT % Difficulty.elapsed_time
