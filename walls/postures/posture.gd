extends AnimatedSprite2D

var SCALE_FACTOR = Vector2.ONE

func _ready():
	var remote_transform = RemoteTransform2D.new()
	remote_transform.update_scale = false
	remote_transform.remote_path = $Outlines.get_path()
	add_child(remote_transform)

func set_posture(index : int):
	play(str(index))
	$Outlines.play(str(index))

func set_posture_scale(new_scale : int):
	scale = new_scale*SCALE_FACTOR
	$Outlines.scale = scale/4.0
