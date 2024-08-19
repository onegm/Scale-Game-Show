extends Node
class_name SongSequence

@onready var time_sequence := FloatIterator.new()
@onready var song := AudioStreamPlayer.new()

static var song_sequence_path = "res://songs/song_timestamps/song_"

signal timestamp_reached

var timers : Array = []
var song_sequence_file : FileAccess

func _init(song_num : int):
	song_sequence_path += str(song_num) + ".txt"
	assert(FileAccess.file_exists(song_sequence_path), "RESOURCE NOT FOUND: " + song_sequence_path)
	song_sequence_file = FileAccess.open(song_sequence_path,FileAccess.READ)

func _ready():
	add_child(song)
	add_child(time_sequence)
	var song_file = song_sequence_file.get_line()
	assert(ResourceLoader.exists(song_file), "Resource does not exist at: " + song_file)
	song.set_stream(ResourceLoader.load(song_file))
	
	var next_line = song_sequence_file.get_line()
	var counter = 0
	while !next_line.contains("end"): 
		if next_line.is_valid_float():
			time_sequence.add(float(next_line))
		next_line = song_sequence_file.get_line()
		counter += 1
		if counter > 1000 : break

func play():
	song.play()
