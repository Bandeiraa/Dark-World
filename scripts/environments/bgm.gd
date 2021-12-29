extends AudioStreamPlayer

func update_bgm(bgm: String, volume: float) -> void:
	set_stream(load(bgm))
	set_volume_db(volume)
	play()
