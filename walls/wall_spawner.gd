extends Node2D
class_name WallSpawner

@onready var wall_posture_scene = load("res://walls/Wall.tscn")
@onready var rand = RandomNumberGenerator.new()

@onready var posture_sequence : WallSequence = Sequence1.new()

func spawn_wall(spawn_position : Vector2):
	if !posture_sequence.has_next():
		return
	var next_posture = posture_sequence.next();

	var new_wall = wall_posture_scene.instantiate()
	add_sibling(new_wall)
	new_wall.global_position = spawn_position
	
	new_wall.set_posture_from_DTO(next_posture)
	
func spawn_random_wall():
	var new_wall = wall_posture_scene.instantiate()
	add_child(new_wall)
	new_wall.set_posture_from_DTO(PostureDTO.get_random())
