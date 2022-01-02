extends Node
class_name EnemyStats

export(int) var health

export(int) var gravity = 100
export(int) var max_fall_velocity = 300

export(int) var attack_limit
export(int) var knockback_force

export(int) var speed
export(int) var attack_speed
export(int) var idle_speed_limit

export(bool) var on_hit

export(float) var friction
export(float) var acceleration
export(float) var knockback_length

func update_health(amount: int, type: String) -> void:
	match type:
		"Damage":
			on_hit = true
			health -= amount
				
		"Heal":
			pass
