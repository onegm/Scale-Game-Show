extends Node

var settings := {
	"MainAudioVolume" : 80
}
var main_scene_path = "res://levels/Level1.tscn"

func get_main_scene():
	return load(main_scene_path)
