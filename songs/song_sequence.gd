extends Node
class_name SongSequence

@onready var song_stream := AudioStream.new()
@onready var time_sequence : Array
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
	var song_file = song_sequence_file.get_line()
	song.set_stream(ResourceLoader.load(song_file))
	
	var next_line = song_sequence_file.get_line()
	var counter = 0
	while !next_line.contains("end"): 
		if next_line.is_valid_float():
			time_sequence.append(float(next_line))
		next_line = song_sequence_file.get_line()
		counter += 1
		if counter > 100 : break
	
	add_timers()

func add_timers():
	for time in time_sequence:
		var timer = Timer.new()
		add_child(timer)
		timer.wait_time = time
		timer.one_shot = true
		timer.timeout.connect(on_timestamp_reached)
		timers.append(timer)

func play():
	song.play()
	for timer in timers:
		timer.start()

func on_timestamp_reached():
	timestamp_reached.emit()
	
