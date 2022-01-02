extends EnemyTemplate
	
func attack(direction: float) -> void:
	on_attack = true
	velocity.x = lerp(0, direction * stats.attack_speed, stats.acceleration)
	
	
func animate() -> void:
	change_direction()
	if stats.on_hit:
		hit_animation()
	elif on_attack and not stats.on_hit:
		attack_animation()
	else:
		move_animation()
		
		
func hit_animation() -> void:
	set_physics_process(false)
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
		
		
func on_animation_finished(anim_name: String) -> void:
	match anim_name:
		"death":
			queue_free()
