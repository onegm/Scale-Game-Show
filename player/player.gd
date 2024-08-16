extends Area2D

func _unhandled_input(_event: InputEvent) -> void:
	var size := 1 + (0.5 * Input.get_axis("size_down", "size_up"))
	scale = Vector2(size, size)
	
	var look_dir := Input.get_axis("look_left", "look_right")
	if look_dir != 0:
		$Sprite2D/Line2D.rotation = 0
		scale.x *= look_dir
	else:
		$Sprite2D/Line2D.rotation_degrees = -90
	
	$Sprite2D.frame = 0
	if Input.is_action_pressed("pose_down"):
		$Sprite2D.frame = 1
	if Input.is_action_pressed("pose_up"):
		$Sprite2D.frame = 2
	if Input.is_action_pressed("pose_left"):
		$Sprite2D.frame = 3
	if Input.is_action_pressed("pose_right"):
		$Sprite2D.frame = 4
