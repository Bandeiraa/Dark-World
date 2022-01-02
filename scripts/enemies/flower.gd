extends EnemyTemplate

var repulsion: Vector2
var player_pos: Vector2 

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
	if stats.health <= 0:
		set_physics_process(false)
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
			
			
func knockback_signal(pos: Vector2) -> void:
	player_pos = pos
	can_knockback = true
	knockback_timer.start(stats.knockback_length)
	
	
func knockback() -> void:
	velocity.x = 0
	var direction: float = sign(global_position.x - player_pos.x)
	repulsion.x = lerp(repulsion.x, direction * stats.knockback_force, stats.acceleration)
	
	repulsion = move_and_slide(repulsion)
	
	
func on_knockback_timeout() -> void:
	player_pos = Vector2.ZERO
	repulsion = Vector2.ZERO
	can_knockback = false
