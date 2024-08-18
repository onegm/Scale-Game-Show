extends Node2D

@export var song_num : int
@onready var wall_spawner = WallSpawner.new()

func _ready():
	var song = SongSequence.new(1)
	add_child(song)
	add_child(wall_spawner)
	song.timestamp_reached.connect(on_timestamp_reached)
	await get_tree().create_timer(3).timeout
	song.play()

func on_timestamp_reached():
	wall_spawner.spawn_wall($WallSpawnPoint.global_position)
