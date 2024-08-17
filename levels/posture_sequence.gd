extends Node
class_name PostureSequence

enum SIZE {SMALL, MEDIUM, LARGE}
enum DIRECTION {CENTER, LEFT, RIGHT}
enum POSTURE {IDLE, WAVE, NINJA, BREAK, KNEEL}

@onready var sequence : Array = []

func has_next() -> bool:
	return !sequence.is_empty()

func next() -> PostureDTO:
	return sequence.pop_front()

func add(postureDTO : PostureDTO):
	sequence.append(postureDTO) 
	
