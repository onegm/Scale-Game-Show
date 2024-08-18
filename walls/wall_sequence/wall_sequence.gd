extends Node
class_name WallSequence

var SIZE := PostureDTO.SIZE
var DIRECTION := PostureDTO.DIRECTION
var POSTURE := PostureDTO.POSTURE

@onready var sequence : Array = []

func has_next() -> bool:
	return !sequence.is_empty()

func next() -> PostureDTO:
	return sequence.pop_front()

func add(postureDTO : PostureDTO):
	sequence.append(postureDTO) 
	
