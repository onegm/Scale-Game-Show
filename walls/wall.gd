extends Area2D

@onready var cutout = $Cutout
@onready var wall = $Cutout/Wall
@onready var cutout_cover = $CutoutCover
@onready var wall_cover = $CutoutCover/WallCover
@onready var outlines = $Outlines
@onready var current_wall_detector := $CurrentWallDetector

var postureDTO : PostureDTO
var speed = Game.WALL_SPEED
var is_current_wall := false

func _ready():
	area_exited.connect(on_area_exited)
	SignalBus.player_miss.connect(on_player_missed)
	current_wall_detector.area_entered.connect(func(_area): is_current_wall=true)
	current_wall_detector.area_exited.connect(func(_area): is_current_wall=false)
	
func on_area_exited(_area):
	SignalBus.wall_hit.emit(postureDTO)

func _physics_process(delta):
	global_position.x -= speed*delta
	if global_position.x < 0:
		queue_free()

func set_posture_from_DTO(new_posture : PostureDTO):
	assert(new_posture.posture in PostureDTO.wall_postures, "Invalid wall posture choice: " + str(new_posture.posture))
	postureDTO = new_posture
	set_wall_and_posture_scale(postureDTO.size)
	cutout.set_posture(postureDTO.posture, postureDTO.direction == postureDTO.DIRECTION.RIGHT)
	cutout_cover.set_posture(postureDTO.posture, postureDTO.direction == postureDTO.DIRECTION.RIGHT)
	
	var posture_num = (postureDTO.posture + PostureDTO.wall_postures.size()) if postureDTO.direction == postureDTO.DIRECTION.RIGHT else postureDTO.posture
	outlines.play(str(posture_num))
	
func set_wall_and_posture_scale(new_scale : float):
	new_scale = (new_scale + 2.0)/1.5
	cutout.set_posture_scale(new_scale)
	cutout_cover.set_posture_scale(new_scale)
	wall.scale /= new_scale
	wall_cover.scale /= new_scale
	outlines.scale = Vector2.ONE*new_scale

func on_player_missed():
	if is_current_wall:
		break_wall()

func break_wall():
	$WallPieces.visible = true
	outlines.visible = false
	cutout.visible = false
	cutout_cover.visible = false
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property($WallPieces/LeftWall, "rotation", -2, 1)
	tween.tween_property($WallPieces/RightWall, "rotation", 2, 1)
	tween.chain().tween_callback($WallPieces.queue_free)
