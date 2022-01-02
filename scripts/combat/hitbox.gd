extends Area2D
class_name Hitbox

onready var timer: Timer = get_node("Timer")

func on_body_entered(_body) -> void:
	pass
	
	
func on_body_exited(_body) -> void:
	pass
	
	
func on_area_entered(_area) -> void:
	pass
	
	
func on_area_exited(_area) -> void:
	pass
	
	
func on_timer_timeout() -> void:
	set_deferred("monitoring", true)
