extends Control

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause_game") && !get_tree().paused:
		get_tree().paused = true
		move_up()

func move_up():
	var tween = get_tree().create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position", Vector2(0, 0), 0.8)

func move_down():
	var tween = get_tree().create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position", Vector2(0, 720), 0.8)

func _on_settings_btn_pressed() -> void:
	$SettingsMenu.move_up()

func _on_close_btn_pressed() -> void:
	get_tree().paused = false
	move_down()
