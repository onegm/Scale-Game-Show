extends Control

@onready var points_label: Label = $CenterContainer/Panel/VBoxContainer/ScoreContainer/PointsLabel
@onready var max_combo_label: Label = $CenterContainer/Panel/VBoxContainer/ScoreContainer/MaxComboLabel

func move_up():
	points_label.text = "Points: %d" % get_parent().points
	max_combo_label.text = "Max Combo: %d" % get_parent().max_combo
	
	var tween = get_tree().create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position", Vector2(0, 0), 0.8)

func _on_again_btn_pressed() -> void:
	get_tree().call_deferred("reload_current_scene")

func _on_exit_btn_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://UI/main_menu/menu_screen.tscn")
