extends Node2D
class_name CinematicManager

onready var cinematic_anim: AnimationPlayer = get_node("CinematicAnimation")
onready var aux_anim: AnimationPlayer = get_node("Animation")

func on_cinematic_animation_finished(_anim_name: String) -> void:
	pass
	
	
func on_aux_animation_finished(_anim_name: String) -> void:
	pass
