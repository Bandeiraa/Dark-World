extends Node2D

const LEVEL_HEIGHT: int = 320

export(int) var level_width

export(String) var level_name
export(PackedScene) var player

onready var wall_pos: Array = [0, level_width]

onready var cinematic: Node2D = get_node("CinematicLevelTutorial")

func _ready() -> void:
	Interface.get_node("FadeContainer").update_visual_message(level_name)
	var _start = Interface.connect("start_level", self, "start_level")
	var _cinematic = cinematic.connect("spawn_player", self, "spawn_player")
	create_floor()
	create_walls()
	
	
func start_level() -> void:
	cinematic.play_cinematic()
	
	
func create_floor() -> void:
	create_body(level_width/2, 272).add_child(create_collision(level_width/2, 16))
	
	
func create_walls() -> void:
	for wall in wall_pos.size():
		create_body(wall_pos[wall], 160).add_child(create_collision(0, 160))
		
		
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
	
	
func spawn_player(player_pos: Vector2) -> void:
	var character: KinematicBody2D = player.instance()
	character.global_position = player_pos
	var main_camera: Camera2D = character.get_node("Camera")
	set_camera_limits(main_camera)
	add_child(character)
	
	
func set_camera_limits(main_camera: Camera2D) -> void:
	main_camera.limit_top = 0
	main_camera.limit_bottom = 320
	main_camera.limit_left = 0
	main_camera.limit_right = level_width
