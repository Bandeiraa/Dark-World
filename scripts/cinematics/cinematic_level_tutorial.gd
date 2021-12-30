extends CinematicManager

signal spawn_player

var current_cinematic_anim_time: float
var can_interact: bool = true

var dialog_index: int = 0

onready var sprite: Sprite = get_node("Texture")

export(Array, String) var text_path_list

func play_cinematic() -> void:
	cinematic_anim.play("cinematic")
	
	
func spawn_dialog() -> void:
	if can_interact:
		current_cinematic_anim_time = stepify(cinematic_anim.get_current_animation_position(), 0.1)
		cinematic_anim.stop()
		Interface.spawn_dialog(text_path_list[dialog_index])
		Interface.connect("dialog_finished", self, "on_dialog_finished")
		can_interact = false
		
		
func on_dialog_finished() -> void:
		cinematic_anim.play("cinematic")
		cinematic_anim.seek(current_cinematic_anim_time)
		can_interact = true
		dialog_index += 1
		
		
func on_cinematic_animation_finished(_anim_name: String) -> void:
	emit_signal("spawn_player", sprite.global_position)
	queue_free()
