extends Control

var can_pause: bool = true

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause") and can_pause:
		get_tree().paused = !get_tree().paused
		visible = !visible
