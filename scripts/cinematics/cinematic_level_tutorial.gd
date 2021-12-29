extends CinematicManager

signal spawn_player

var current_cinematic_anim_time: float
var can_interact: bool = true

onready var sprite: Sprite = get_node("Texture")

func play_cinematic() -> void:
	cinematic_anim.play("cinematic")
	
	
func spawn_dialogue() -> void:
	if can_interact:
		current_cinematic_anim_time = stepify(cinematic_anim.get_current_animation_position(), 0.1)
		cinematic_anim.stop()
		cinematic_anim.play("cinematic")
		cinematic_anim.seek(current_cinematic_anim_time)
		can_interact = false
		
		
func on_cinematic_animation_finished(_anim_name: String) -> void:
	emit_signal("spawn_player", sprite.global_position)
	queue_free()
