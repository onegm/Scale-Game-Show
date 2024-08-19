extends WallSequence
class_name Sequence2
# Scale, direction, posture
#9, intro, 12-20
#6 chorus loop 1, 21-26
#6 chorus loop 2, 27-32
#17 breakdown, 33-49
#6 chorus loop 3, 50-55
#6 chorus loop 4, 56-61
func _init():
	sequence = [
		PostureDTO.new(SIZE.MEDIUM, DIRECTION.RIGHT, POSTURE.FIGHT),
	]
