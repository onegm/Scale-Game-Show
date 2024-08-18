extends AnimatedSprite2D

var SCALE_FACTOR = Vector2.ONE

func set_posture(index : int):
	play(str(index))

func set_posture_scale(new_scale : int):
	scale = new_scale*SCALE_FACTOR
