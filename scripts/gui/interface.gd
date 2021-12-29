extends CanvasLayer

signal start_level

func on_animation_finished(anim_name: String) -> void:
	match anim_name:
		"fade_out":
			emit_signal("start_level")
