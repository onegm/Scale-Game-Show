extends Control

func _ready():
	AudioManager.main_menu_sound.play()

func _on_settings_btn_pressed() -> void:
	$SettingsMenu.move_up()

func _on_quit_btn_pressed() -> void:
	get_tree().call_deferred("quit")

func _on_start_btn_pressed() -> void:
	AudioManager.main_menu_sound.stop()
	Game.song_num = 1
	Game.wall_sequence_num = 1
	get_tree().call_deferred("change_scene_to_file", "res://levels/Level1.tscn")

func _on_start_btn_2_pressed():
	AudioManager.main_menu_sound.stop()
	Game.song_num = 2
	Game.wall_sequence_num = 2
	get_tree().call_deferred("change_scene_to_file", "res://levels/Level1.tscn")


func _on_start_btn_tutorial_pressed():
	AudioManager.main_menu_sound.stop()
	Game.song_num = 3
	Game.wall_sequence_num = 3
	get_tree().call_deferred("change_scene_to_file", "res://levels/Level1.tscn")
