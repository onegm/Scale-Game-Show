extends Area2D

# x: size , y: look_dir, z: pose_frame
var player_state := Vector3(1, 0, 0)
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
	player_state.x = Input.get_axis("size_down", "size_up")
	player_state.y = Input.get_axis("look_left", "look_right")
	player_state.z = 0
	
	if player_state.y != 0:
		if Input.is_action_pressed("pose_down"):
			player_state.z = 1
		if Input.is_action_pressed("pose_up"):
			player_state.z = 2
		if Input.is_action_pressed("pose_left"):
			player_state.z = 3
		if Input.is_action_pressed("pose_right"):
			player_state.z = 4
		if last_pose != player_state.z:
			pose_hit()
	
	scale = Vector2(1 + (0.5 * player_state.x), 1 + (0.5 * player_state.x))
	$Sprite2D.flip_h = (player_state.y == -1) 
	$Sprite2D.frame = player_state.z
	last_pose = int(player_state.z)

func on_wall_hit(wall_pose : PostureDTO) -> void:
	if last_pose_timer < 200:
		score = "Perfect"
	elif last_pose_timer < 400:
		score = "Great"
	else:
		score = "Normal"
	
	if wall_pose.size == (player_state.x + 1) && wall_pose.direction == abs(player_state.y) + (1 if player_state.y > 0 else 0) && wall_to_player(int(wall_pose.posture)) == player_state.z:
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

func wall_to_player(wall_pose_num : int) -> int:
	match wall_pose_num:
		1:
			return 2
		2:
			return 3
		3:
			return 4
		4:
			return 1
	return 0
