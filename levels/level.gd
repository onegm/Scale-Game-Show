extends Node2D

@export var song_num : int
@export var wall_sequence_num : int
@export var random_walls : bool
@onready var wall_spawner := WallSpawner.new(wall_sequence_num)

func _ready():
	add_child(wall_spawner)
	
	var song = SongSequence.new(song_num)
	add_child(song)
	song.timestamp_reached.connect(on_timestamp_reached)
	await get_tree().create_timer(3).timeout
	song.play()

func on_timestamp_reached():
	if random_walls:
		wall_spawner.spawn_random_wall($WallSpawnPoint.global_position)
	else:
		wall_spawner.spawn_wall($WallSpawnPoint.global_position)
