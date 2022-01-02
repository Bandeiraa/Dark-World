extends Hurtbox
class_name CharacterHurtbox

var player_position: Vector2

func _process(_delta: float) -> void:
	player_position = get_parent().global_position
