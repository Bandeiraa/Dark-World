extends Hurtbox
class_name EnemyHurtbox

var enemy_position: Vector2

func _process(_delta: float) -> void:
	enemy_position = get_parent().global_position
