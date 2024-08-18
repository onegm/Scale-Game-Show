extends Area2D

# x: size , y: look_dir, z: pose
var player_state := Vector3i(1, 0, 0)
var point_counter : int = 0
var combo_meter : int = 0
var last_pose_timer : int = -1
var score := "normal"
var last_pose := 0

func _ready() -> void:
	SignalBus.wall_hit.connect(on_wall_hit)

func _physics_process(_delta: float) -> void:
	$ComboLabel.set_text(str(last_pose_timer))
	if last_pose_timer == -1 || last_pose_timer > 999:
		return
	last_pose_timer += 1

func _unhandled_input(_event: InputEvent) -> void:
	var ready_pose := false
	player_state.x = int(Input.get_axis("size_down", "size_up"))
	player_state.y = int(Input.get_axis("look_left", "look_right"))
	player_state.z = 0
	
	if player_state.y != 0:
		if Input.is_action_pressed("pose_down"):
			player_state.z = 4
		if Input.is_action_pressed("pose_up"):
			player_state.z = 1
		if Input.is_action_pressed("pose_left"):
			player_state.z = 2
		if Input.is_action_pressed("pose_right"):
			player_state.z = 3
		if last_pose != player_state.z:
			pose_hit()
		if player_state.z == 0:
			ready_pose = true
	
	scale = Vector2(1 + (0.5 * player_state.x), 1 + (0.5 * player_state.x))
	$Sprite2D.flip_h = (player_state.y != -1)
	$Sprite2D.texture = load("res://player/%s.png" % num_to_file(player_state.z)) if !ready_pose else load("res://player/Ready.png")
	last_pose = int(player_state.z)

func on_wall_hit(wall_pose : PostureDTO) -> void:
	if last_pose_timer < 50:
		score = "Perfect"
	elif last_pose_timer < 100:
		score = "Great"
	else:
		score = "Normal"
	
	if wall_pose.size == (player_state.x + 1) && wall_pose.direction == abs(player_state.y) + (1 if player_state.y > 0 else 0) && wall_pose.posture == player_state.z+1:
		point_counter += 1
		combo_meter += 1
		$PointsLabel.set_text(score)
		#$PointsLabel.set_text(str(point_counter))
		#$ComboLabel.set_text(str("x", combo_meter))
		$Anim.play("right_pose")
	else:
		$PointsLabel.set_text("Miss")
		combo_meter = 0
		$ComboLabel.set_text(str("x", combo_meter))

func pose_hit():
	last_pose_timer = 0

# IDLE, READY, POINT, WAVE, FIGHT, CROUCH
func num_to_file(pose_num : int) -> String:
	match pose_num:
		1:
			return "Point"
		2:
			return "Wave"
		3:
			return "Fight"
		4:
			return "Crouch"
	return "Idle"
