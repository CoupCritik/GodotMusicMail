extends RichTextLabel

var full_text: String = "une belle fleur"

func _ready() -> void:
	bbcode_enabled = true
	visible_characters
	update_display()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("activation"):
		if visible_characters < full_text.length():
			visible_characters += 1
			update_display()

func update_display() -> void:
	var result: String = ""
	var n: int = visible_characters

	if n <= 0:
		text = ""
		return

	if n > 2:
		var normal_text: String = full_text.substr(0, n - 2)
		result += "[color=black]" + normal_text + "[/color]"

	if n >= 2:
		var dark_gray: String = full_text.substr(n - 2, 1)
		result += "[color=darkgray]" + dark_gray + "[/color]"

	if n >= 1:
		var light_gray: String = full_text.substr(n - 1, 1)
		result += "[color=lightgray]" + light_gray + "[/color]"

	text = result
