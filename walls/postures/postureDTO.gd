extends Node
class_name PostureDTO

enum SIZE {SMALL, MEDIUM, LARGE}
enum DIRECTION {CENTER, LEFT, RIGHT}
enum POSTURE {IDLE, WAVE, NINJA, BREAK, KNEEL}

var size : SIZE
var direction : DIRECTION
var posture : POSTURE

func _init(new_size : SIZE, 
		   new_direction : DIRECTION,
		   new_posture : POSTURE):
			
	size = new_size
	direction = new_direction
	posture = new_posture

static func get_random():
	var rand = RandomNumberGenerator.new()
	return PostureDTO.new(
		rand.randi_range(0, SIZE.size()-1),
		rand.randi_range(0, DIRECTION.size()-1),
		rand.randi_range(0, POSTURE.size()-1)
	)
