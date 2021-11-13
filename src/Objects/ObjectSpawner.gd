extends Position2D

export(Array, PackedScene) var objects: Array
onready var spawn_timer: Timer = $SpawnTimer
onready var floor_raycast: RayCast2D = $FloorCheck


func _ready() -> void:
	randomize()
	randomize_spawn_time()

func randomize_spawn_time() -> void:
	var random_spawn_time = rand_range(2, 4)
	spawn_timer.start(random_spawn_time)

func spawn_random_obstacle() -> void:
	var random_index = randi() % objects.size()
	var obstacle: Obstacle = objects[random_index].instance()
	get_parent().add_child(obstacle)
	var floor_position = floor_raycast.get_collision_point() - (obstacle.size / 2) \
		if floor_raycast.is_colliding() else global_position
	obstacle.global_position = floor_position

func _on_SpawnTimer_timeout() -> void:
	spawn_random_obstacle()
	randomize_spawn_time()
