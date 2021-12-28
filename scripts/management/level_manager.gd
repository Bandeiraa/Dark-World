extends Node2D

export(int) var level_width

func _ready() -> void:
	create_floor()
	
	
func create_floor() -> void:
	create_body().add_child(create_collision())
	
	
func create_body() -> StaticBody2D:
	var static_body: StaticBody2D = StaticBody2D.new()
	static_body.position = Vector2(level_width/2, 272)
	add_child(static_body)
	return static_body
	
	
func create_collision() -> CollisionShape2D:
	var collision: CollisionShape2D = CollisionShape2D.new()
	var collision_shape: RectangleShape2D = RectangleShape2D.new()
	collision.set_shape(collision_shape)
	collision_shape.set_extents(Vector2(level_width/2, 16))
	return collision
	
