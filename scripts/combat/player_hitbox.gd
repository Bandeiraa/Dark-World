extends Hitbox
class_name CharacterHitbox

signal update_health

func on_area_entered(area: EnemyHurtbox) -> void:
	if area is EnemyHurtbox:
		emit_signal("update_health", area.damage, area.type)
		set_deferred("monitoring", false)
		timer.start(invulnerability_time)
