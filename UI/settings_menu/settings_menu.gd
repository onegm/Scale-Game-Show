extends Control

func move_up():
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position", Vector2(0, 0), 0.8)

func move_down():
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position", Vector2(0, 720), 0.8)


func _on_close_btn_pressed() -> void:
	move_down()
