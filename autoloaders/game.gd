extends Node

var settings := {
	"MainAudioVolume" : 1
}
var main_scene_path = "res://levels/Level1.tscn"
var WALL_SPEED = 200.0

func get_main_scene():
	return load(main_scene_path)
