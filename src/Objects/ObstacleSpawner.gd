extends Position2D

export(NodePath) var game_gui_path := "../GameGUI"
export(Array, PackedScene) var obstacles: Array
export(float, 0, 30) var min_spawn_time := 2.0
export(float, 0, 30) var max_spawn_time := 4.0

onready var game_gui: GameGUI = get_node(game_gui_path)
onready var spawn_timer: Timer = $SpawnTimer
onready var floor_raycast: RayCast2D = $FloorCheck


func _ready() -> void:
	randomize()
	randomize_spawn_time()


func randomize_spawn_time() -> void:
	var random_spawn_time = rand_range(min_spawn_time, max_spawn_time) * Difficulty.spawn_modifier
	spawn_timer.start(random_spawn_time)


func spawn_random_obstacle() -> void:
	var random_index = randi() % obstacles.size()
	var obstacle = obstacles[random_index].instance()
	get_parent().add_child(obstacle)
	var floor_position = (
		floor_raycast.get_collision_point() - (obstacle.size / 2)
		if floor_raycast.is_colliding()
		else global_position
	)
	floor_position.x = get_viewport().size.x
	obstacle.global_position = floor_position
	if obstacle is Enemy:
		var connected = obstacle.connect("defeated", game_gui.score_gui, "_on_Enemy_defeated")
		if connected != OK:
			push_warning("Could not connect enemy defeated")


func _on_SpawnTimer_timeout() -> void:
	spawn_random_obstacle()
	randomize_spawn_time()
