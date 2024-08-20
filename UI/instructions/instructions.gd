extends Control

func _ready():
	$Button.pressed.connect(on_button_pressed)
	$Audio1.play()
	get_tree().paused = true
	
func on_button_pressed():
	if $Text1.visible:
		$Text1.visible = false
		$Audio1.stop()
		$Text2.visible = true
		$Audio2.play()
	elif $Text2.visible:
		$Text2.visible = false
		$Audio2.stop()
		$Text3.visible = true
		$Audio3.play()
	else:
		get_tree().paused = false
		queue_free()
