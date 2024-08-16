extends Node2D

@onready var wall_posture_scene = load("res://walls/WallPosture.tscn")
@onready var timer = $Timer
@onready var rand = RandomNumberGenerator.new()

func _ready():
	timer.timeout.connect(spawn_wall)
	
func spawn_wall():
	var new_wall = wall_posture_scene.instantiate()
	add_child(new_wall)
	new_wall.set_posture(rand.randi_range(0, 8))
