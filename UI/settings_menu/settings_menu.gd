extends Control

@onready var MainAudioSlider := $CenterContainer/Panel/VBoxContainer/MainAudioSlider

var local_settings := {
	"MainAudioVolume" : 80
}

func _ready() -> void:
	load_settings()

func move_up():
	MainAudioSlider.value = local_settings["MainAudioVolume"]
	
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position", Vector2(0, 0), 0.8)

func move_down():
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position", Vector2(0, 720), 0.8)

func save_settings():
	for keys in Game.settings.keys():
		Game.settings[keys] = local_settings[keys]
func load_settings():
	for keys in Game.settings.keys():
		local_settings[keys] = Game.settings[keys]

func _on_close_btn_pressed() -> void:
	move_down()
	save_settings()

func _on_h_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		local_settings["MainAudioVolume"] = MainAudioSlider.value
