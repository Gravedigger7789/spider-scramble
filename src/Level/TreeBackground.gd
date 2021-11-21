extends ParallaxBackground

export var velocity: Vector2 = Vector2(-400, 0)

onready var tree_spawner: SpriteSpawner = $TreeSpawner
onready var shrub_spawner: SpriteSpawner = $ShrubSpawner
onready var foliage_spawner: SpriteSpawner = $FoliageSpawner


func _ready():
	tree_spawner.sprite_velocity = velocity
	shrub_spawner.sprite_velocity = velocity
	foliage_spawner.sprite_velocity = velocity


func _process(delta: float) -> void:
	var offset: Vector2 = get_scroll_offset() + velocity * delta * Difficulty.speed_modifier
	set_scroll_offset(offset)
