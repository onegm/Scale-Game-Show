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
	#new_wall.set_posture(rand.randi_range(0, 8))
	#new_wall.set_wall_and_posture_scale(rand.randi_range(1, 3))
	
	new_wall.set_wall_and_posture_scale(next_posture.size + 1)
	var posture_num = max(0, next_posture.posture*2 - (1 if next_posture.direction % 2 == 0 else 0))
	new_wall.set_posture(posture_num)
