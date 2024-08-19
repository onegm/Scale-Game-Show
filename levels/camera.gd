extends Camera2D

@onready var initial_position := global_position
var player_position : Vector2

var rand = RandomNumberGenerator.new()
var current_shake_strength : float = 0.0

const SHAKE_STRENGTH : float = 4.0
const SHAKE_DECAY : float = 10.0

func _ready():
	rand.randomize()
	SignalBus.player_miss.connect(shake)
	SignalBus.final_wall_entered.connect(on_final_wall_entered)

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

func set_player_position(new_player_position : Vector2):
	player_position = new_player_position

func on_final_wall_entered():
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property(self, "zoom", zoom*2, 1)
	tween.tween_property(self, "global_position:x", player_position.x, 1)
	await start_slow_motion()
	var tween2 = get_tree().create_tween().set_parallel(true)
	tween2.tween_property(self, "zoom", zoom/2, 1)
	tween2.tween_property(self, "global_position:x", initial_position.x, 1)
	stop_slow_motion()

func start_slow_motion(time_scale: float = 0.25) -> void:
	Engine.time_scale = time_scale
	AudioServer.playback_speed_scale = time_scale
	await get_tree().create_timer(3, false, false, true).timeout

# Run the game at normal speed.
func stop_slow_motion() -> void:
	Engine.time_scale = 1.0
	AudioServer.playback_speed_scale = 1.0
	pass
