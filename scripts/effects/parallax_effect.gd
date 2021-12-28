extends AnimatedSprite

export(float) var min_wait_time = 1.0
export(float) var max_wait_time = 5.0

func _ready() -> void:
	create_timer()
	
	
func create_timer() -> void:
	var timer: Timer = Timer.new()
	var _signal = timer.connect("timeout", self, "on_timer_timeout", [timer])
	add_child(timer)
	timer.start(get_random_wait_time())
	
	
func get_random_wait_time() -> float:
	randomize()
	return rand_range(min_wait_time, max_wait_time)
	
	
func on_timer_timeout(timer: Timer) -> void:
	timer.queue_free()
	playing = true
	play("effect")
	
	
func on_animation_finished() -> void:
	create_timer()
	playing = false
	frame = 0
