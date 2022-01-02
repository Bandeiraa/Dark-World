extends KinematicBody2D
class_name EnemyTemplate

onready var detection_area: Area2D = get_node("DetectionArea")

onready var stats: Node = get_node("Stats")
onready var sprite: Sprite = get_node("Texture")
onready var animation: AnimationPlayer = get_node("Animation")

var velocity: Vector2

var on_attack: bool = false

func _physics_process(_delta: float) -> void:
	if detection_area.body_ref != null:
		var distance: int = detection_area.body_ref.global_position.x - global_position.x
		var direction: float = sign(distance)
		if abs(distance) < stats.attack_limit:
			attack(direction)
		else:
			move(direction)
			
	else:
		idle()
		
	animate()
	velocity = move_and_slide(velocity, Vector2.UP)
		
		
func idle() -> void:
	on_attack = false
	velocity.x = lerp(velocity.x, 0, stats.friction)
	
	
func move(direction: float) -> void:
	on_attack = false
	velocity.x = lerp(0, direction * stats.speed, stats.acceleration)
	
	
func attack(_direction: float) -> void:
	pass
		
		
func animate() -> void:
	pass
	
	
func change_direction() -> void:
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true
