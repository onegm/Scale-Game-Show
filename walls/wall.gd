extends Area2D

@onready var cutout = $Cutout
@onready var outlines = $Outlines
@onready var current_wall_detector := $CurrentWallDetector

var postureDTO : PostureDTO
var speed = Game.WALL_SPEED
var is_current_wall := false
var is_final_wall := false

func _ready():
	area_exited.connect(on_area_exited)
	SignalBus.player_miss.connect(on_player_missed)
	current_wall_detector.area_entered.connect(func(_area): is_current_wall=true)
	current_wall_detector.area_exited.connect(func(_area): is_current_wall=false)
	
	cutout.set_wall($Wall)
	cutout.set_cover($WallCover)
	
func on_area_exited(_area):
	SignalBus.wall_hit.emit(postureDTO)

func _physics_process(delta):
	global_position.x -= speed*delta
	if global_position.x < -200:
		queue_free()

func set_posture_from_DTO(new_posture : PostureDTO):
	assert(new_posture.posture in PostureDTO.wall_postures, "Invalid wall posture choice: " + PostureDTO.POSTURE.keys()[new_posture.posture])
	postureDTO = new_posture
	set_cutout_and_outline_scale(postureDTO.size)
	cutout.set_posture(postureDTO.posture, postureDTO.direction == postureDTO.DIRECTION.RIGHT)
	
	var posture_num = (postureDTO.posture + PostureDTO.wall_postures.size()) if postureDTO.direction == postureDTO.DIRECTION.RIGHT else postureDTO.posture
	outlines.play(str(posture_num))
	
func set_cutout_and_outline_scale(new_scale : float):
	new_scale = (new_scale + 2.0)/1.5
	cutout.set_posture_scale(new_scale)
	outlines.scale = Vector2.ONE*new_scale

func on_player_missed():
	if is_current_wall:
		break_wall()

func break_wall():
	$WallPieces.visible = true
	outlines.visible = false
	cutout.visible = false
	$MotionParticles.emitting = false
	$BreakParticles.emitting = true
	var tween = get_tree().create_tween().set_parallel(true).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property($WallPieces/LeftWall, "rotation", -2, 1)
	tween.tween_property($WallPieces/RightWall, "rotation", 2, 1)
	tween.tween_property($WallPieces/RightWall, "position:x", 400, 1)
	tween.tween_property($WallPieces, "position:y", 700, 1).set_ease(Tween.EASE_IN)
