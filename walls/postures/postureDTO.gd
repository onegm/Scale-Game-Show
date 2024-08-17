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
