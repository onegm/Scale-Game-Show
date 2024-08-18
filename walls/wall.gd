extends Area2D

@onready var posture = $Posture
@onready var outlines = $Outlines
@onready var wall = $Posture/Wall

var postureDTO : PostureDTO
var speed = Game.WALL_SPEED

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
	assert(new_posture.posture in PostureDTO.wall_postures, "Invalid wall posture choice: " + str(new_posture.posture))
	postureDTO = new_posture
	set_wall_and_posture_scale(postureDTO.size)
	posture.set_posture(postureDTO.posture, postureDTO.direction == postureDTO.DIRECTION.RIGHT)
	
	var posture_num = (postureDTO.posture + PostureDTO.wall_postures.size()) if postureDTO.direction == postureDTO.DIRECTION.RIGHT else postureDTO.posture
	outlines.play(str(posture_num))
	
func set_wall_and_posture_scale(new_scale : float):
	new_scale = (new_scale + 2.0)/1.5
	posture.set_posture_scale(new_scale)
	wall.scale /= new_scale
	outlines.scale = Vector2.ONE*new_scale
