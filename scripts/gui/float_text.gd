extends Label
class_name FloatText

onready var tween: Tween = get_node("Tween")

func _ready() -> void:
	randomize()
	
	
func show_value(value: int, travel: Vector2, duration: float, spread: float) -> void:
	yield(self, "ready")
	text = str(value)
	
	var movement: Vector2 = travel.rotated(rand_range(-spread/2, spread/2))
	rect_pivot_offset = rect_size/2
	
	var _rect_pos = tween.interpolate_property(
		self,
		"rect_position",
		rect_position,
		rect_position + movement,
		duration,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	
	var _modulate = tween.interpolate_property(
		self,
		"modulate:a",
		1.0,
		0.0,
		duration,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	
	var _start = tween.start()
	yield(tween, "tween_all_completed")
	queue_free()
