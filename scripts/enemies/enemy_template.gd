extends KinematicBody2D
class_name EnemyTemplate

onready var detection_area: Area2D = get_node("DetectionArea")

onready var stats: Node = get_node("Stats")
onready var sprite: Sprite = get_node("Texture")
onready var animation: AnimationPlayer = get_node("Animation")

onready var knockback_timer: Timer = get_node("Knockback")

var velocity: Vector2
var repulsion: Vector2
var player_pos: Vector2

var on_attack: bool = false
var can_knockback: bool = false

func _physics_process(_delta: float) -> void:
	if can_knockback:
		knockback()
		
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
	if not can_knockback:
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
	
	
func on_animation_finished(_anim_name: String) -> void:
	pass
