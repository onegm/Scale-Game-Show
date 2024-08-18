extends Control

@onready var DownPoseRect: TextureRect = $VBoxContainer/LowContainer/VBoxContainer/DownPoseRect
@onready var UpPoseRect: TextureRect = $VBoxContainer/LowContainer/VBoxContainer/UpPoseRect
@onready var LeftPoseRect: TextureRect = $VBoxContainer/LowContainer/LeftPoseRect
@onready var RightPoseRect: TextureRect = $VBoxContainer/LowContainer/RightPoseRect

var last_pose := 0

func _unhandled_input(_event: InputEvent) -> void:
	#var size_input := int(Input.get_axis("size_down", "size_up"))
	#var dir_input := int(Input.get_axis("look_left", "look_right"))
	var pose_input := 0
	
	if Input.is_action_pressed("pose_down"):
		pose_input = 1
	if Input.is_action_pressed("pose_up"):
		pose_input = 2
	if Input.is_action_pressed("pose_left"):
		pose_input = 3
	if Input.is_action_pressed("pose_right"):
		pose_input = 4
	
	if pose_input == last_pose:
		return
	last_pose = pose_input
	
	DownPoseRect.material.set_shader_parameter("outline_color", Vector4(1,1,0,0))
	UpPoseRect.material.set_shader_parameter("outline_color", Vector4(1,1,0,0))
	LeftPoseRect.material.set_shader_parameter("outline_color", Vector4(1,1,0,0))
	RightPoseRect.material.set_shader_parameter("outline_color", Vector4(1,1,0,0))
	
	match pose_input:
		1:
			DownPoseRect.material.set_shader_parameter("outline_color", Vector4(1,1,0,1))
		2:
			UpPoseRect.material.set_shader_parameter("outline_color", Vector4(1,1,0,1))
		3:
			LeftPoseRect.material.set_shader_parameter("outline_color", Vector4(1,1,0,1))
		4:
			RightPoseRect.material.set_shader_parameter("outline_color", Vector4(1,1,0,1))
