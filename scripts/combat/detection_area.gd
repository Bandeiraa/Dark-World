extends Area2D
class_name DetectionArea

var body_ref: Object = null

func on_body_entered(body: CharacterTemplate) -> void:
	if body is CharacterTemplate:
		body_ref = body
		
		
func on_body_exited(_body: CharacterTemplate) -> void:
	body_ref = null
