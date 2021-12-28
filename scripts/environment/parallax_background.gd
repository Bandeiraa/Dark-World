extends ParallaxBackground

onready var fog: ParallaxLayer = get_node("Fog")

export(int) var fog_speed

func _physics_process(delta: float) -> void:
	#fog.motion_offset.x -= delta * fog_speed
	pass
