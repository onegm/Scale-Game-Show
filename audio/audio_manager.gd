extends Node

var perfect_run := true

func _ready():
	perfect_run = true
	SignalBus.combo.connect(on_combo)
	SignalBus.player_miss.connect(on_player_miss)
	SignalBus.song_ended.connect(on_song_end)
	$MainMenuSound.play()

func on_combo(combo_streak : int):
	match combo_streak:
		5:
			$ComboNice.play()
		15:
			$ComboGreat.play()
		25:
			$ComboAwesome.play()
		40:
			$ComboFire.play()
	
func on_song_end():
	if perfect_run:
		$ComboFull.play()

func on_player_miss():
	perfect_run = false
	$MissSFX.play()
