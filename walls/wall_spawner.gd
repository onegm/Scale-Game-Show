extends Node2D
class_name WallSpawner

@onready var wall_scene = load("res://walls/Wall.tscn")
@onready var rand = RandomNumberGenerator.new()

var wall_sequence : WallSequence
var wall_sequence_path = "res://walls/wall_sequence/wall_sequence_"
var start_time : int

var distance : float
var time_sequence : FloatIterator

func _init(sequence_num : int):
	wall_sequence_path += str(sequence_num) + ".gd"
	assert(ResourceLoader.exists(wall_sequence_path), "RESOURCE NOT FOUND: " + wall_sequence_path)
	wall_sequence = load(wall_sequence_path).new()

func spawn_wall() -> Wall:
	var new_wall = wall_scene.instantiate()
	add_sibling(new_wall)
	return new_wall	

func spawn_wall_from_sequence(is_final_wall : bool):
	if !wall_sequence.has_next():
		return
	var next_posture = wall_sequence.next();
	var wall := spawn_wall()
	wall.set_posture_from_DTO(next_posture)
	wall.is_final_wall = is_final_wall
	if wall.is_final_wall:
		print(wall.postureDTO)
	
func spawn_random_wall():
	var wall = spawn_wall()
	wall.set_posture_from_DTO(PostureDTO.get_random_wall())

func offset_time_by_position(new_time_sequence : FloatIterator, player_position : Vector2):
	distance = player_position.distance_to(global_position)
	time_sequence = new_time_sequence

func start():
	start_time = Time.get_ticks_msec()
	while time_sequence.has_next():
		await spawn_timer()
	
func spawn_timer():
	var time = time_sequence.next()
	time -= (Time.get_ticks_msec()-start_time)/1000.0
	time -= distance / Game.WALL_SPEED
	if time < 0:
		return
	await get_tree().create_timer(time, false).timeout
	spawn_wall_from_sequence(!time_sequence.has_next())
