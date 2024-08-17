extends Node2D

@export var song_num : int
@onready var wall_spawner = WallSpawner.new()

func _ready():
	$WallSpawnPoint.add_child(wall_spawner)
	var song = SongSequence.new(1)
	add_child(song)
	song.timestamp_reached.connect(on_timestamp_reached)
	await get_tree().create_timer(3).timeout
	song.play()

func on_timestamp_reached():
	wall_spawner.spawn_wall()
