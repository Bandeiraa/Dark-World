extends Control

onready var visual_message: Label = get_node("Text")

func update_visual_message(message: String) -> void:
	visual_message.text = message
	Interface.get_node("Animation").play("fade_out")
