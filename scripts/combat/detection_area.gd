extends Area2D
class_name DetectionArea

var body_ref: Object = null

func on_body_entered(body: Object) -> void:
	body_ref = body
	
	
func on_body_exited(_body: Object) -> void:
	body_ref = null
