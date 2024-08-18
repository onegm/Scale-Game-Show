extends Control


func _on_start_btn_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://levels/Level1.tscn")

func _on_settings_btn_pressed() -> void:
	$SettingsMenu.move_up()

func _on_quit_btn_pressed() -> void:
	get_tree().call_deferred("quit")
