extends VBoxContainer

onready var fps: Label = get_node("Fps")
onready var memory: Label = get_node("Memory")

func _process(_delta: float) -> void:
	fps.text = "Quadros por segundo(Fps): " + str(Engine.get_frames_per_second())
	var memory_usage = stepify(float(OS.get_static_memory_usage())/1048576, 0.1)
	memory.text = "Memória em uso: " + str(memory_usage) + " Mb" # 1024/1024 to get value in mbs
