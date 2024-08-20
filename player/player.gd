extends Area2D

var player_state := PostureDTO.new(PostureDTO.SIZE.MEDIUM,PostureDTO.DIRECTION.CENTER,PostureDTO.POSTURE.IDLE)
var point_counter : int = 0
var combo_meter : int = 0
var last_pose_timer : int = -1
var score := "normal"
var last_pose := 0

func _ready() -> void:
	SignalBus.wall_hit.connect(on_wall_hit)

func _physics_process(_delta: float) -> void:
	#$ComboLabel.set_text(str(last_pose_timer))
	if last_pose_timer == -1 || last_pose_timer >= 500:
		return
	last_pose_timer += 1

func _unhandled_input(_event: InputEvent) -> void:
	var size_input := int(Input.get_axis("size_down", "size_up"))
	var dir_input := int(Input.get_axis("look_left", "look_right"))
	player_state.posture = PostureDTO.POSTURE.IDLE
	
	if dir_input != 0:
		if Input.is_action_pressed("pose_down"):
			player_state.posture = PostureDTO.POSTURE.CROUCH
		if Input.is_action_pressed("pose_up"):
			player_state.posture = PostureDTO.POSTURE.POINT
		if Input.is_action_pressed("pose_left"):
			player_state.posture = PostureDTO.POSTURE.WAVE
		if Input.is_action_pressed("pose_right"):
			player_state.posture = PostureDTO.POSTURE.FIGHT
		
		if player_state.posture == PostureDTO.POSTURE.IDLE:
			player_state.posture = PostureDTO.POSTURE.READY
		if last_pose != player_state.posture:
			pose_hit()
	
	scale = Vector2(1 + (0.35 * size_input), 1 + (0.35 * size_input))
	$Sprite2D.flip_h = (dir_input != -1)
	$Sprite2D.texture = load("res://player/%s.png" % num_to_file(player_state.posture))
	last_pose = int(player_state.posture)
	
	player_state.size = (size_input + 1) as PostureDTO.SIZE
	player_state.direction = abs(dir_input) + (1 if dir_input > 0 else 0)

func on_wall_hit(wall_pose : PostureDTO) -> void:
	if last_pose_timer <= 50:
		score = "Perfect!!"
	elif last_pose_timer <= 100:
		score = "Great!"
	else:
		score = "OK"
	
	if wall_pose.equals(player_state):
		match score:
			"Perfect!!":
				point_counter += (200 + (5 * combo_meter))
			"Great!":
				point_counter += (100 + (2 * combo_meter))
			"OK":
				point_counter += (50 + (combo_meter))
		combo_meter += 1
		SignalBus.score_update.emit(point_counter, combo_meter, score)
		$Anim.play("right_pose")
	else:
		combo_meter = 0
		SignalBus.score_update.emit(point_counter, combo_meter, "Miss")
		SignalBus.player_miss.emit()

func pose_hit():
	last_pose_timer = 0

func num_to_file(pose_num : int) -> String:
	match pose_num:
		PostureDTO.POSTURE.CROUCH:
			return "Crouch"
		PostureDTO.POSTURE.POINT:
			return "Point"
		PostureDTO.POSTURE.WAVE:
			return "Wave"
		PostureDTO.POSTURE.FIGHT:
			return "Fight"
		PostureDTO.POSTURE.READY:
			return "Ready"
	return "Idle"
