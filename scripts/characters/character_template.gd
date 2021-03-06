extends KinematicBody2D
class_name CharacterTemplate

onready var camera: Camera2D = get_node("Camera")

onready var knockback_timer: Timer = get_node("KnockbackTimer")

onready var hitbox_collision: CollisionShape2D = get_node("Hitbox/Collision")
onready var hurtbox: Area2D = get_node("Hurtbox")

onready var stats: Node = get_node("Stats")
onready var sprite: Sprite = get_node("Texture")
onready var animation: AnimationPlayer = get_node("Animation")

var velocity: Vector2
var repulsion: Vector2
var enemy_pos: Vector2

var handle_input: bool = true
var can_knockback: bool = false

export(PackedScene) var sfx
export(String) var current_attack

export(bool) var on_attack = false

func _physics_process(delta: float) -> void:
	if handle_input:
		handle_movement()
		gravity(delta)
		attack()
		if not can_knockback:
			velocity = move_and_slide(velocity, Vector2.UP)
		else:
			knockback()
			
	animate()
	
	
func handle_movement() -> void:
	if get_sprint():
		move(stats.run_speed)
	else:
		move(stats.walk_speed)
		
		
func get_sprint() -> bool:
	return Input.is_action_pressed("sprint")
	
	
func move(speed: int) -> void:
	if get_dir() != 0:
		velocity.x = lerp(velocity.x, get_dir() * speed, stats.acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, stats.friction)
		
		
func get_dir() -> float:
	return Input.get_action_strength("right") - Input.get_action_strength("left")
	
	
func gravity(delta: float) -> void:
	velocity.y += stats.gravity * delta
	if velocity.y >= stats.max_fall_velocity:
		velocity.y = stats.max_fall_velocity
		
		
func attack() -> void:
	var jump_attack: bool = Input.is_action_pressed("jump_attack")
	var throw_dagger: bool = Input.is_action_just_pressed("throw_dagger")
	
	if jump_attack and Input.is_action_just_pressed("jump") and current_attack == "":
		current_attack = "air_attack"
	elif throw_dagger and current_attack == "":
		current_attack = "throw_dagger"
		
		
func animate() -> void:
	check_direction()
	if not stats.on_hit and current_attack == "":
		move_animation()
		return
		
	if stats.on_hit:
		hit_animation()
	elif current_attack != "":
		attack_animation()
		
		
func check_direction() -> void:
	if velocity.x > 0:
		hitbox_collision.position = Vector2(2, 30)
		hurtbox.scale.x = 1
		sprite.flip_h = false
	elif velocity.x < 0:
		hurtbox.scale.x = -1
		hitbox_collision.position = Vector2(-2, 30)
		sprite.flip_h = true
		
		
func move_animation() -> void:
	if abs(velocity.x) > stats.idle_speed_limit and get_sprint():
		animation.play("run")
	elif abs(velocity.x) > stats.idle_speed_limit:
		animation.play("walk")
	else:
		animation.play("idle")
		
		
func attack_animation() -> void:
	animation.play(current_attack)
	
	
func hit_animation() -> void:
	if stats.health <= 0:
		set_physics_process(false)
		animation.play("death")
		return
		
	camera.add_trauma(0.1)
	animation.play("hit")
	
	
func instance_sfx(sound: String, volume: int) -> void:
	var sfx_scene: Sfx = sfx.instance()
	sfx_scene.set_sfx(sound, volume)
	get_tree().root.call_deferred("add_child", sfx_scene)
			
			
func knockback_signal(pos: Vector2) -> void:
	enemy_pos = pos
	can_knockback = true
	knockback_timer.start(stats.knockback_length)
	
	
func knockback() -> void:
	velocity.x = 0
	var direction: float = sign(global_position.x - enemy_pos.x)
	repulsion.x = lerp(repulsion.x, direction * stats.knockback_force, stats.acceleration)
	
	repulsion = move_and_slide(repulsion)
	
	
func on_knockback_timeout() -> void:
	enemy_pos = Vector2.ZERO
	repulsion = Vector2.ZERO
	can_knockback = false
	
func on_animation_finished(anim_name: String) -> void:
	match anim_name:
		"death":
			queue_free()
