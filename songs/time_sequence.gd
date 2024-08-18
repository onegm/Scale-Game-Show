extends Node
class_name TimeSequence

@onready var sequence : Array = []

func has_next() -> bool:
	return !sequence.is_empty()

func next() -> float:
	return sequence.pop_front()

func add(time : float):
	sequence.append(time) 
	
