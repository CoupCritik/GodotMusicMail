extends Label

@export var full_text: String = "feur"
var current_index: int = 0

func _ready():
	text = ""  # On vide le texte au début

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and current_index < full_text.length():
		current_index += 1
		text = full_text.substr(0, current_index)
