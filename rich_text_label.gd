extends RichTextLabel

var texte_a_ecrire: String = "bonjour"
var etape: int = 0  # Nombre de lettres tapées correctement

func _ready() -> void:
	bbcode_enabled = true
	update_display()

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if etape >= texte_a_ecrire.length():
			return  # Tout est déjà tapé

		var charactere_attendu := texte_a_ecrire[etape]
		var input := OS.get_keycode_string(event.keycode).to_lower()

		if input == charactere_attendu.to_lower():
			etape += 1
			update_display()

func update_display() -> void:
	var result := ""

	for i in texte_a_ecrire.length():
		if i < etape:
			result += "[color=black]" + texte_a_ecrire[i] + "[/color]"
		elif i == etape:
			result += "[color=darkgray]" + texte_a_ecrire[i] + "[/color]"
		elif i == etape + 1:
			result += "[color=lightgray]" + texte_a_ecrire[i] + "[/color]"

	text = result
