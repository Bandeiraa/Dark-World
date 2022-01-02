extends Hitbox
class_name EnemyHitbox

signal update_health

func on_area_entered(area: CharacterHurtbox) -> void:
	if area is CharacterHurtbox:
		emit_signal("update_health", area.damage, area.type)
		set_deferred("monitoring", false)
		timer.start(area.invulnerability_time)
