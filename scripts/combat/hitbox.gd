extends Area2D
class_name Hitbox

var invulnerability_time: float

onready var timer: Timer = get_node("Timer")

func on_body_entered(_body: Object) -> void:
	pass
	
	
func on_body_exited(_body: Object) -> void:
	pass
	
	
func on_area_entered(_area: Object) -> void:
	pass
	
	
func on_area_exited(_area: Object) -> void:
	pass
	
	
func on_timer_timeout() -> void:
	set_deferred("monitoring", true)
