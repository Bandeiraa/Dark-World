extends Node2D

const LEVEL_HEIGHT: int = 320

export(int) var level_width
export(int) var collision_offset

onready var wall_pos: Array = [0 - collision_offset, level_width + collision_offset]

onready var dagger_mush: KinematicBody2D = get_node("DaggerMush")
onready var main_camera: Camera2D = dagger_mush.get_node("Camera")

func _ready() -> void:
	set_camera_limits()
	create_floor()
	create_walls()
	
	
func set_camera_limits() -> void:
	main_camera.limit_top = 0
	main_camera.limit_bottom = 0
	main_camera.limit_left = 0 - collision_offset
	main_camera.limit_right = level_width + collision_offset
	
	
func create_floor() -> void:
	create_body(level_width/2, 272).add_child(create_collision(level_width/2, 16))
	
	
func create_walls() -> void:
	for wall in wall_pos.size():
		create_body(wall_pos[wall], 160).add_child(create_collision(collision_offset, 160))
		
		
func create_body(x_pos: int, y_pos: int) -> StaticBody2D:
	var static_body: StaticBody2D = StaticBody2D.new()
	static_body.position = Vector2(x_pos, y_pos)
	add_child(static_body)
	return static_body
	
	
func create_collision(x_size: int, y_size: int) -> CollisionShape2D:
	var collision: CollisionShape2D = CollisionShape2D.new()
	var collision_shape: RectangleShape2D = RectangleShape2D.new()
	collision.set_shape(collision_shape)
	collision_shape.set_extents(Vector2(x_size, y_size))
	return collision
