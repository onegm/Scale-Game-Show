extends Control

@onready var MainAudioSlider := $CenterContainer/Panel/VBoxContainer/MainAudioSlider
@onready var ControlsTopBox: CheckBox = $CenterContainer/Panel/VBoxContainer/ControlsTopBox

var local_settings := {
	"MainAudioVolume" : 1,
	"ControlsOnTop" : false
}

func _ready() -> void:
	load_settings()
	MainAudioSlider.value = local_settings["MainAudioVolume"]
	ControlsTopBox.button_pressed = local_settings["ControlsOnTop"]

func move_up():
	var tween = get_tree().create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position", Vector2(0, 0), 0.8)

func move_down():
	var tween = get_tree().create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
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
	SignalBus.settings_updated.emit()

func _on_h_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		AudioServer.set_bus_volume_db(0, linear_to_db(MainAudioSlider.value))
		local_settings["MainAudioVolume"] = MainAudioSlider.value

# Get the volume of the bus 
# local_settings["MainAudioVolume"] = db_to_linear(AudioServer.get_bus_volume_db(0))

func _on_controls_top_box_toggled(toggled_on: bool) -> void:
	local_settings["ControlsOnTop"] = toggled_on
