extends Position2D

export(Array, PackedScene) var obstacles: Array
export (float, 0, 30) var min_spawn_time := 2.0
export (float, 0, 30) var max_spawn_time := 4.0
onready var spawn_timer: Timer = $SpawnTimer
onready var floor_raycast: RayCast2D = $FloorCheck


func _ready() -> void:
	randomize()
	randomize_spawn_time()

func randomize_spawn_time() -> void:
	var random_spawn_time = rand_range(min_spawn_time, max_spawn_time)
	spawn_timer.start(random_spawn_time)

func spawn_random_obstacle() -> void:
	var random_index = randi() % obstacles.size()
	var obstacle: Obstacle = obstacles[random_index].instance()
	get_parent().add_child(obstacle)
	var floor_position = floor_raycast.get_collision_point() - (obstacle.size / 2) \
		if floor_raycast.is_colliding() else global_position
	obstacle.global_position = floor_position

func _on_SpawnTimer_timeout() -> void:
	spawn_random_obstacle()
	randomize_spawn_time()
