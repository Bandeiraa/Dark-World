extends Control

onready var text_indicator: Sprite = get_node("DialogBox/TextEndIndicator")

onready var timer: Timer = get_node("Timer")

onready var dialog_name: RichTextLabel = get_node("DialogBox/DialogName")
onready var dialog_text: RichTextLabel = get_node("DialogBox/DialogText")

var dialog: Array

var dialog_index: int = 0
var dialog_finished: bool = false

export(String) var dialog_path
export(float) var text_speed = 0.05

func _ready() -> void:
	timer.set_wait_time(text_speed)
	dialog = get_dialog()
	assert(dialog, "Diálogo não encontrado!")
	next_dialog()
	
	
func _process(_delta: float) -> void:
	text_indicator.visible = dialog_finished
	if Input.is_action_just_pressed("enter"):
		if dialog_finished:
			next_dialog()
		else:
			dialog_text.visible_characters = len(dialog_text.text)
			
			
func get_dialog() -> Array:
	var f = File.new()
	assert(f.file_exists(dialog_path), "Arquivo de texto não existe!")
	
	f.open(dialog_path, File.READ)
	var json: String = f.get_as_text()
	
	var output: Array = parse_json(json)
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []
		
		
func next_dialog() -> void:
	if dialog_index >= len(dialog):
		queue_free()
		return
		
	dialog_finished = false
	
	dialog_name.bbcode_text = dialog[dialog_index]["Name"]
	dialog_text.bbcode_text = dialog[dialog_index]["Text"]
	dialog_text.visible_characters = 0
	
	while dialog_text.visible_characters < len(dialog_text.text):
		dialog_text.visible_characters += 1
		yield(timer, "timeout")
		
	dialog_finished = true
	dialog_index += 1
	return
