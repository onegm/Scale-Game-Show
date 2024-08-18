extends Control

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause_game") && !get_tree().paused:
		move_up()

func move_up():
	get_tree().paused = true
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

func _on_exit_btn_pressed() -> void:
	get_tree().paused = false
	get_tree().call_deferred("change_scene_to_file", "res://UI/main_menu/menu_screen.tscn")
