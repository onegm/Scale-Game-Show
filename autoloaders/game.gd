extends Node

var settings := {
	"MainAudioVolume" : 1,
	"ControlsOnTop" : false
}
var main_scene_path = "res://levels/Level1.tscn"
var WALL_SPEED = 250.0

var BRICK_WALL_TEXTURE : CompressedTexture2D = load("res://walls/art/walls/color/brick_wall.png")
var FOAM_WALL_TEXTURE : CompressedTexture2D = load("res://walls/art/walls/color/foam_wall.png")
var CONCRETE_WALL_TEXTURE : CompressedTexture2D = load("res://walls/art/walls/color/concrete_wall.png")


func get_main_scene():
	return load(main_scene_path)
