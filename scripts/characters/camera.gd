extends Camera2D
class_name CharacterCamera

export(float) var decay = 0.8
export(float) var max_roll = 0.1

export(Vector2) var max_offset = Vector2(100, 75)
export(NodePath) var target

var trauma: float = 0.0
var trauma_power: int = 2

var noise_y: float = 0

onready var noise: OpenSimplexNoise = OpenSimplexNoise.new()

func _ready() -> void:
	randomize()
	noise.seed = randi()
	noise.period = 4
	noise.octaves = 2
	
	
func add_trauma(amount: float) -> void:
	trauma = min(trauma + amount, 1.0)
	
	
func _process(delta: float) -> void:
	if target:
		global_position = get_node(target).global_position
		
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()
		
		
func shake() -> void:
	var amount: float = pow(trauma, trauma_power)
	noise_y += 1
	rotation = max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
	offset.x = max_offset.x * amount * noise.get_noise_2d(noise.seed * 2, noise_y)
	offset.y = max_offset.y * amount * noise.get_noise_2d(noise.seed * 3, noise_y)
