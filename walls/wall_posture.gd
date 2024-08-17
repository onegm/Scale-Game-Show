extends Area2D

@onready var posture = $Posture

var postureDTO : PostureDTO
var speed = 100

func _ready():
	area_entered.connect(on_area_entered)
	
func on_area_entered(_area):
	SignalBus.wall_hit.emit(postureDTO)

func _physics_process(delta):
	global_position.x -= speed*delta
	if global_position.x < 0:
		queue_free()

func set_posture_from_DTO(new_posture : PostureDTO):
	postureDTO = new_posture
	set_wall_and_posture_scale(postureDTO.size + 1)
	var posture_num = max(0, postureDTO.posture*2 - (1 if postureDTO.direction % 2 == 0 else 0))
	posture.set_posture(posture_num)
	
func set_wall_and_posture_scale(new_scale : int):
	posture.set_posture_scale(new_scale)
	$Posture/Wall.scale /= new_scale
