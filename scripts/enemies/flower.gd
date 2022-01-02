extends EnemyTemplate

func attack(direction: float) -> void:
	on_attack = true
	velocity.x = lerp(0, direction * stats.attack_speed, stats.acceleration)
	
	
func animate() -> void:
	change_direction()
	if on_hit:
		hit_animation()
	if on_attack and not on_hit:
		attack_animation()
	else:
		move_animation()
		
		
func hit_animation() -> void:
	if stats.health <= 0:
		animation.play("death")
		return
		
	animation.play("hit")
	
	
func attack_animation() -> void:
	animation.play("attack")
	
	
func move_animation() -> void:
	if abs(velocity.x) > stats.idle_speed_limit:
		animation.play("move")
	else:
		animation.play("idle")
