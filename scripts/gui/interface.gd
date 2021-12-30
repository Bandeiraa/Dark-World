extends CanvasLayer

signal start_level
signal dialog_finished

onready var debug_information: VBoxContainer = get_node("DebugInformation")

func on_animation_finished(anim_name: String) -> void:
	match anim_name:
		"fade_out":
			emit_signal("start_level")
			debug_information.show()
