extends Node2D

@onready var wall_posture_scene = load("res://walls/WallPosture.tscn")
@onready var timer = $Timer
@onready var rand = RandomNumberGenerator.new()

@onready var posture_sequence : PostureSequence = Sequence1.new()

func _ready():
	timer.timeout.connect(spawn_wall)
	
func spawn_wall():
	if !posture_sequence.has_next():
		return
	var next_posture = posture_sequence.next();

	var new_wall = wall_posture_scene.instantiate()
	add_child(new_wall)
	
	new_wall.set_posture_from_DTO(next_posture)
	
func spawn_random_wall():
	var new_wall = wall_posture_scene.instantiate()
	add_child(new_wall)
	new_wall.set_posture_from_DTO(PostureDTO.get_random())
