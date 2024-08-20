extends Node2D

@export var song_num : int
@export var wall_sequence_num : int
@export var random_walls : bool
@onready var wall_spawner := WallSpawner.new(wall_sequence_num)
@onready var wall_spawn_marker := $WallSpawnPoint
@onready var player := $Player

func _ready():
	wall_spawn_marker.add_child(wall_spawner)
	var song = SongSequence.new(song_num)
	add_child(song)
	wall_spawner.offset_time_by_position(song.time_sequence, player.position)
	await get_tree().create_timer(2, false).timeout
	song.play()
	wall_spawner.start()
	$Camera.set_player_position(player.global_position)
	$AnimationPlayer.play("crowd_bounce")
