extends Node
class_name EnemyStats

const FLOAT_TEXT = preload("res://scenes/gui/float_text.tscn")

export(int) var health

export(int) var gravity = 100
export(int) var max_fall_velocity = 300

export(int) var attack_limit
export(int) var knockback_force

export(int) var speed
export(int) var attack_speed
export(int) var idle_speed_limit

export(bool) var on_hit

export(float) var spread: float = PI/2
export(float) var duration = 2.0

export(float) var friction
export(float) var acceleration

export(float) var knockback_length

export(Vector2) var travel = Vector2(0, -80)

func update_health(amount: int, type: String) -> void:
	match type:
		"Damage":
			on_hit = true
			health -= amount
			show_float_text(amount)
				
		"Heal":
			pass
			
			
func show_float_text(amount: int) -> void:
	var text: FloatText = FLOAT_TEXT.instance()
	get_tree().root.call_deferred("add_child", text)
	text.rect_position = get_parent().global_position
	text.show_value(amount, travel, duration, spread)
