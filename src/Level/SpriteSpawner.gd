extends Position2D
class_name SpriteSpawner


var sprites : Array

export var sprite_velocity: Vector2 = Vector2( -400, 0 );
export(Array, Texture) var textures: Array
export (float, 0, 30) var min_spawn_time := 2.0
export (float, 0, 30) var max_spawn_time := 4.0

onready var spawn_timer: Timer = $SpawnTimer
onready var floor_raycast: RayCast2D = $FloorCheck


func _ready() -> void:
	randomize()
	randomize_spawn_time()

func create_sprite(texture: Texture) -> MovingSprite:
	var sprite := MovingSprite.new()
	sprite.texture = texture
	sprite.velocity = sprite_velocity
	return sprite

func randomize_spawn_time() -> void:
	var random_spawn_time := rand_range(min_spawn_time, max_spawn_time)
	spawn_timer.start(random_spawn_time)

func spawn_random_sprite() -> void:
	var random_index := randi() % textures.size()
	var texture: Texture = textures[random_index]
	var sprite := create_sprite(texture)
	add_child(sprite)
	var sprite_size := Vector2(sprite.texture.get_width(), sprite.texture.get_height())
	var floor_position := floor_raycast.get_collision_point() - (sprite_size / 2) \
		if floor_raycast.is_colliding() else global_position
	sprite.global_position = floor_position

func _on_SpawnTimer_timeout() -> void:
	spawn_random_sprite()
	randomize_spawn_time()
