extends Node
class_name PostureDTO

var size : PostureSequence.SIZE
var direction : PostureSequence.DIRECTION
var posture : PostureSequence.POSTURE

func _init(new_size : PostureSequence.SIZE, 
		   new_direction : PostureSequence.DIRECTION,
		   new_posture : PostureSequence.POSTURE):
			
	size = new_size
	direction = new_direction
	posture = new_posture

static func get_random():
	var rand = RandomNumberGenerator.new()
	return PostureDTO.new(
		rand.randi_range(0, PostureSequence.SIZE.size()-1),
		rand.randi_range(0, PostureSequence.DIRECTION.size()-1),
		rand.randi_range(0, PostureSequence.POSTURE.size()-1)
	)
