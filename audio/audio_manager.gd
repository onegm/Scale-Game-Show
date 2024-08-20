extends Node

var perfect_run := true

func _ready():
	perfect_run = true
	SignalBus.combo.connect(on_combo)
	SignalBus.player_miss.connect(func() : perfect_run = false)
	SignalBus.song_ended.connect(on_song_end)

func on_combo(combo_streak : int):
	match combo_streak:
		5:
			$ComboNice.play()
		10:
			$ComboGreat.play()
		20:
			$ComboAwesome.play()
		30:
			$ComboFire.play()
		40:
			$ComboGetAway.play()
	
func on_song_end():
	if perfect_run:
		$ComboFull.play()
