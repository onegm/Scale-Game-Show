extends Node2D

@onready var posture = $Posture
var posture_numDTO : int
var posture_scaleDTO : int
var posture_directionDTO : int

var speed = 100

func _ready():
	$Area2D.area_entered.connect(on_area_entered)
	
func on_area_entered(_area):
	SignalBus.wall_hit.emit(Vector3(posture_scaleDTO, posture_directionDTO, posture_numDTO))

func _physics_process(delta):
	global_position.x -= speed*delta
	if global_position.x < 0:
		queue_free()

func set_posture(new_posture : int):
	posture.set_posture(new_posture)
	posture_numDTO = ceil(new_posture/2.0)
	posture_directionDTO = -1 if new_posture % 2 == 0 else 1
	
func set_wall_and_posture_scale(new_scale : int):
	posture.set_posture_scale(new_scale)
	$Posture/Wall.scale /= new_scale
	posture_scaleDTO = new_scale - 2
