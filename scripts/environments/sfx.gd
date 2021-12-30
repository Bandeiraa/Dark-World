extends AudioStreamPlayer
class_name Sfx

func set_sfx(sfx: String, volume: float) -> void:
	set_stream(load(sfx))
	set_volume_db(volume)
	play()
	
	
func on_sfx_finished() -> void:
	queue_free()
