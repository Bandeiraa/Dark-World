extends KinematicBody2D
class_name CharacterTemplate

onready var stats: Node = get_node("Stats")
onready var animation: AnimationPlayer = get_node("Animation")

var velocity: Vector2

func _physics_process(delta: float) -> void:
	handle_movement()
	gravity(delta)
	velocity = move_and_slide(velocity, Vector2.UP)
	
	
func handle_movement() -> void:
	if get_sprint():
		move(stats.run_speed)
	else:
		move(stats.walk_speed)
		
		
func get_sprint() -> bool:
	return Input.is_action_pressed("sprint")
	
	
func move(speed: int) -> void:
	if get_dir() != 0:
		lerp(velocity.x, get_dir() * speed, stats.acceleration)
	else:
		lerp(velocity.x, 0, stats.friction)
		
		
func get_dir() -> float:
	return Input.get_action_strength("right") - Input.get_action_strength("left")
	
	
func gravity(delta: float) -> void:
	velocity.y += stats.gravity * delta
	if velocity.y >= stats.max_fall_velocity:
		velocity.y = stats.max_fall_velocity
