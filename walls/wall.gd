extends Area2D

@onready var posture = $Posture
@onready var outlines = $Outlines

var postureDTO : PostureDTO
var speed = 100

func _ready():
	area_entered.connect(on_area_entered)
	
func on_area_entered(_area):
	SignalBus.wall_hit.emit(postureDTO)
	z_index += 1

func _physics_process(delta):
	global_position.x -= speed*delta
	if global_position.x < 0:
		queue_free()

func set_posture_from_DTO(new_posture : PostureDTO):
	postureDTO = new_posture
	set_wall_and_posture_scale(postureDTO.size + 1)
	posture.set_posture(postureDTO.posture, postureDTO.direction == postureDTO.DIRECTION.RIGHT)

	var posture_num = max(0, postureDTO.posture*2 - (1 if postureDTO.direction % 2 == 0 else 0))
	outlines.play(str(min(8, posture_num)))
	
func set_wall_and_posture_scale(new_scale : int):
	posture.set_posture_scale(new_scale)
	$Posture/Wall.scale /= new_scale
	outlines.scale = (Vector2.ONE/4.0)*new_scale
