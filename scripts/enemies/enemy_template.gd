extends KinematicBody2D
class_name EnemyTemplate

onready var detection_area: Area2D = get_node("DetectionArea")

onready var stats: Node = get_node("Stats")
onready var sprite: Sprite = get_node("Texture")
onready var animation: AnimationPlayer = get_node("Animation")

var velocity: Vector2

func _physics_process(_delta: float) -> void:
	if detection_area.body_ref != null:
		var distance: int = global_position.x - detection_area.body_ref.global_position.x
		if abs(distance) < stats.attack_limit:
			attack()
		else:
			move()
			
	else:
		move()
			
	velocity = move_and_slide(velocity, Vector2.UP)
		
		
func move() -> void:
	if detection_area.body_ref != null:
		var direction: int = (global_position.x - detection_area.body_ref.global_position.x).normalized()
		velocity.x = lerp(0, direction * stats.speed, stats.acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, stats.friction)
		
		
func attack() -> void:
	pass
	
	
func animate() -> void:
	pass
