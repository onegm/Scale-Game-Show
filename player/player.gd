extends Area2D

# x: size , y: look_dir, z: pose_frame
var player_state := Vector3(1, 0, 0)

func _ready() -> void:
	SignalBus.wall_hit.connect(on_wall_hit)

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
	
	scale = Vector2(1 + (0.5 * player_state.x), 1 + (0.5 * player_state.x))
	$Sprite2D.flip_h = (player_state.y == -1) 
	$Sprite2D.frame = player_state.z

func on_wall_hit(wall_pose : Vector3) -> void:
	if wall_pose.x == player_state.x && wall_pose.y == player_state.y && wall_to_player(int(wall_pose.z)) == player_state.z:
		$Label.set_text("Nice fit")
	else:
		$Label.set_text("Ouch")

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
