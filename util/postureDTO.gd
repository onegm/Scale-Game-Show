extends Node
class_name PostureDTO #Data transfer object

enum SIZE {SMALL, MEDIUM, LARGE}
enum DIRECTION {CENTER, LEFT, RIGHT}
enum POSTURE {IDLE, READY, POINT, WAVE, FIGHT, CROUCH}
static var wall_postures = [POSTURE.POINT, POSTURE.WAVE, POSTURE.FIGHT, POSTURE.CROUCH]

var size : SIZE
var direction : DIRECTION
var posture : POSTURE

func _init(new_size : SIZE, 
		   new_direction : DIRECTION,
		   new_posture : POSTURE):
			
	size = new_size
	direction = new_direction
	posture = new_posture

static func get_random_wall():
	var rand = RandomNumberGenerator.new()
	return PostureDTO.new(
		rand.randi_range(0, SIZE.size()-1),
		rand.randi_range(0, DIRECTION.size()-1),
		rand.randi_range(2, POSTURE.size()-1)
	)

func equals(other : PostureDTO) -> bool:
	if size == other.size and direction == other.direction and posture == other.posture:
		return true
	return false

func _to_string():
	var result = "{\n"
	result += "\tPosture: " + POSTURE.keys()[posture] + "\n"
	result += "\tSize: " + SIZE.keys()[size] + "\n"
	result += "\tDirection: " + DIRECTION.keys()[direction] + "\n"
	result += "}"
	return result
