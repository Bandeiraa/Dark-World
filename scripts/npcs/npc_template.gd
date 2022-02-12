extends Area2D

var player_ref: CharacterTemplate

var can_interact: bool = false

export(String) var text_path

func _process(_delta: float):
	if can_interact and Input.is_action_just_pressed("interact"):
		player_ref.handle_input = false
		spawn_dialog()
		
		
func on_body_entered(body: CharacterTemplate) -> void:
	if body is CharacterTemplate:
		can_interact = true
		player_ref = body
		
		
func on_body_exited(body: CharacterTemplate) -> void:
	if body is CharacterTemplate:
		can_interact = false
		player_ref = null
		
		
func spawn_dialog() -> void:
	Interface.spawn_dialog(text_path)
	var _finished = Interface.connect("dialog_finished", self, "on_dialog_finished")
	can_interact = false
		
		
func on_dialog_finished() -> void:
	print("Spawnar Diálogo")
	#store_to_instance.connect("closed", self, "on_shop_closed")
	
	
func on_shop_closed() -> void:
	player_ref.handle_input = true
	can_interact = true
