extends KinematicBody2D
class_name CharacterTemplate

onready var stats: Node = get_node("Stats")
onready var sprite: Sprite = get_node("Texture")
onready var animation: AnimationPlayer = get_node("Animation")

var velocity: Vector2

func _physics_process(delta: float) -> void:
	handle_movement()
	gravity(delta)
	velocity = move_and_slide(velocity, Vector2.UP)
	check_direction()
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
		
		
func check_direction() -> void:
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true
		
		
func animate() -> void:
	move_animation()
		
		
func move_animation() -> void:
	if abs(velocity.x) > stats.idle_speed_limit and get_sprint():
		#animation.play("run")
		pass
	elif abs(velocity.x) > stats.idle_speed_limit:
		animation.play("walk")
	else:
		animation.play("idle")
