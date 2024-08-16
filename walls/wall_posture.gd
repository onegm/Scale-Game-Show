extends Node2D

@onready var posture = $Posture

var speed = 100

func _physics_process(delta):
	global_position.x -= speed*delta
	if global_position.x < 0:
		queue_free()

func set_posture(posture_num : int):
	posture.set_posture(posture_num)
	
func set_wall_and_posture_scale(new_scale : int):
	posture.set_posture_scale(new_scale)
	$Posture/Wall.scale /= new_scale
