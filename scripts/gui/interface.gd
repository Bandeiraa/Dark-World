extends CanvasLayer

signal start_level
signal dialog_finished

export(PackedScene) var dialog_scene

onready var pause_container: Control = get_node("PauseContainer")
onready var debug_information: VBoxContainer = get_node("DebugInformation")

func on_animation_finished(anim_name: String) -> void:
	match anim_name:
		"fade_out":
			emit_signal("start_level")
			debug_information.show()
			
			
func spawn_dialog(dialog_path: String) -> void:
	pause_container.can_pause = false
	var dialog: DialogManager = dialog_scene.instance()
	dialog.dialog_path = dialog_path
	var _finished = dialog.connect("dialog_finished", self, "on_dialog_finished")
	add_child(dialog)
	
	
func on_dialog_finished() -> void:
	emit_signal("dialog_finished")
	pause_container.can_pause = true
	
