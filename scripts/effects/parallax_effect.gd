extends AnimatedSprite

onready var timer: Timer = get_node("Timer")
onready var sfx: AudioStreamPlayer = get_node("Sfx")

export(bool) var has_sfx = false

export(float) var min_wait_time = 1.0
export(float) var max_wait_time = 5.0

export(float) var sound_volume = 0.0

export(String) var sound

func _ready() -> void:
	if has_sfx:
		configure_sfx()
		
	timer.start(get_random_wait_time())
	
	
func get_random_wait_time() -> float:
	randomize()
	return rand_range(min_wait_time, max_wait_time)
	
	
func on_timer_timeout() -> void:
	playing = true
	if has_sfx:
		sfx.play(0.0)
		
	play("effect")
	
	
func on_animation_finished() -> void:
	timer.start(get_random_wait_time())
	sfx.stop()
	playing = false
	frame = 0
	
	
func configure_sfx() -> void:
	sfx.set_stream(load(sound))
	sfx.set_volume_db(sound_volume)
