extends Control

@onready var PointsLabel: Label = $VBoxContainer/HighContainer/ScoreContainer/PointsLabel
@onready var ComboLabel: Label = $VBoxContainer/HighContainer/ScoreContainer/ComboLabel
@onready var TimingLabel: Label = $VBoxContainer/HighContainer/ScoreContainer/TimingLabel

@onready var SizeUpRect: TextureRect = $VBoxContainer/LowContainer/SizeDirContainer/SizeContainer/SizeUpRect
@onready var SizeDownRect: TextureRect = $VBoxContainer/LowContainer/SizeDirContainer/SizeContainer/SizeDownRect
@onready var LeftDirRect: TextureRect = $VBoxContainer/LowContainer/SizeDirContainer/LeftDirRect
@onready var RightDirRect: TextureRect = $VBoxContainer/LowContainer/SizeDirContainer/RightDirRect
@onready var PosesRect: TextureRect = $VBoxContainer/LowContainer/PosesRect

var points := 0
var max_combo := 0

var last_size := 0
var last_dir := 0
var last_pose := 0

func _ready() -> void:
	SignalBus.score_update.connect(on_score_update)
	SignalBus.settings_updated.connect(on_settings_updated)
	SignalBus.song_ended.connect(on_music_finished)
	$VBoxContainer.move_child($VBoxContainer/LowContainer, int(!Game.settings["ControlsOnTop"]))

func on_score_update(new_points : int, combo : int, timing : String):
	PointsLabel.set_text(str(new_points))
	ComboLabel.set_text(str("x", combo))
	TimingLabel.set_text(timing)
	
	points = new_points
	max_combo = max(combo, max_combo)

func on_settings_updated():
	$VBoxContainer.move_child($VBoxContainer/LowContainer, int(!Game.settings["ControlsOnTop"]))

func on_music_finished():
	$FinishScreen.move_up()
	$PauseMenu.queue_free()

func _unhandled_input(_event: InputEvent) -> void:
	var size_input := int(Input.get_axis("size_down", "size_up"))
	if size_input != last_size:
		if size_input == 0:
			SizeUpRect.texture.set_atlas(load("res://UI/Elements/WASD HUD element - W.png"))
			SizeDownRect.texture.set_atlas(load("res://UI/Elements/WASD HUD element - S.png"))
		elif size_input == 1:
			SizeUpRect.texture.set_atlas(load("res://UI/Elements/WASD HUD element - W Highlight.png"))
		else:
			SizeDownRect.texture.set_atlas(load("res://UI/Elements/WASD HUD element - S Highlight.png"))
	last_size = size_input
	
	var dir_input := int(Input.get_axis("look_left", "look_right"))
	if dir_input != last_dir:
		if dir_input == 0:
			LeftDirRect.texture.set_atlas(load("res://UI/Elements/WASD HUD element - A.png"))
			RightDirRect.texture.set_atlas(load("res://UI/Elements/WASD HUD element - D.png"))
		elif dir_input == 1:
			RightDirRect.texture.set_atlas(load("res://UI/Elements/WASD HUD element - D Highlight.png"))
		else:
			LeftDirRect.texture.set_atlas(load("res://UI/Elements/WASD HUD element - A Highlight.png"))
	last_dir = dir_input
	
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
	
	PosesRect.texture = load("res://UI/Elements/Arrow Keys HUD element.png")
	
	match pose_input:
		1:
			PosesRect.texture = load("res://UI/Elements/Arrow Keys HUD element - Down Highlight.png")
		2:
			PosesRect.texture = load("res://UI/Elements/Arrow Keys HUD element - Up Highlight.png")
		3:
			PosesRect.texture = load("res://UI/Elements/Arrow Keys HUD element - Left Highlight.png")
		4:
			PosesRect.texture = load("res://UI/Elements/Arrow Keys HUD element - Right Highlight.png")
