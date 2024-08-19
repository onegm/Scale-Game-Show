extends Camera2D

var rand = RandomNumberGenerator.new()
var current_shake_strength : float = 0.0

const SHAKE_STRENGTH : float = 4.0
const SHAKE_DECAY : float = 10.0

func _ready():
	rand.randomize()
	SignalBus.player_miss.connect(shake)

func _process(delta):
	if current_shake_strength > 1e-5:
		current_shake_strength = lerp(current_shake_strength, 0.0, SHAKE_DECAY*delta)
		set_offset(get_shake_offset())

func shake():
	current_shake_strength = SHAKE_STRENGTH

func get_shake_offset():
	return Vector2(
		rand.randfn(0, current_shake_strength),
		rand.randfn(0, current_shake_strength)		
	)
