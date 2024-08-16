extends AnimatedSprite2D


func _ready():
	var remote_transform = RemoteTransform2D.new()
	remote_transform.remote_path = $Outlines.get_path()
	add_child(remote_transform)

func set_posture(index : int):
	play(str(index))
	$Outlines.play(str(index))
