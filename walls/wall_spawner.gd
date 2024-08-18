extends Node2D
class_name WallSpawner

@onready var wall_scene = load("res://walls/Wall.tscn")
@onready var rand = RandomNumberGenerator.new()

var posture_sequence : WallSequence
var posture_sequence_path = "res://walls/wall_sequence/wall_sequence_"

func _init(sequence_num : int):
	posture_sequence = load(posture_sequence_path + str(sequence_num) + ".gd").new()

func spawn_wall(spawn_position : Vector2):
	if !posture_sequence.has_next():
		return
	var next_posture = posture_sequence.next();

	var new_wall = wall_scene.instantiate()
	add_sibling(new_wall)
	new_wall.global_position = spawn_position
	
	new_wall.set_posture_from_DTO(next_posture)
	
func spawn_random_wall(spawn_position : Vector2):
	var new_wall = wall_scene.instantiate()
	add_sibling(new_wall)
	new_wall.global_position = spawn_position
	new_wall.set_posture_from_DTO(PostureDTO.get_random())
