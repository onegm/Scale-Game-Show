extends AnimatedSprite2D

func set_posture(index : int, flipped : bool):
	flip_h = flipped
	play(str(index))

func set_posture_scale(new_scale : float):
	scale = new_scale*Vector2.ONE
