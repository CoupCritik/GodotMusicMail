extends RichTextLabel

var texte_a_ecrire: String = "bonjour_les_amis,_ça_va?⏎pas_moi,⏎à_mon_grand_damne."
var etape: int = 0  # Nombre de lettres tapées correctement

func _ready() -> void:
	bbcode_enabled = true
	#var font = FontFile.new()
	#font.font_data = load("res://NotoSans-Medium.ttf")
	#font.font_weight=300
	#self.add_theme_font_override("font", font)
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
		if input == "space" and charactere_attendu == "_" :
			etape +=1
			update_display()
		if input == "semicolon" and charactere_attendu == "." :
			etape +=1
			update_display()
		if input == "enter" and charactere_attendu =="⏎" :
			etape +=1
			update_display()
		if input =="9" and charactere_attendu == "ç":
			etape +=1
			update_display()
		if input == "comma":
			if charactere_attendu =="?" or charactere_attendu == ",":
				etape +=1
				update_display()
		if input == "0" and charactere_attendu == "à":
			etape +=1
			update_display()

func update_display() -> void:
	var result := ""

	for i in texte_a_ecrire.length():
		if i < etape:
			if texte_a_ecrire[i] == "_":
				result += " "
			if texte_a_ecrire[i] == "⏎":
				result += "\n"
			elif texte_a_ecrire[i] != "_" and texte_a_ecrire[i] != "⏎":
				result += "[color=black]" + texte_a_ecrire[i] + "[/color]"
		elif i == etape:
			result += "[color=darkgray]" + "|" + "[/color]"
			result += "[color=darkgray]" + texte_a_ecrire[i] + "[/color]"
		elif i == etape + 1:
			result += " "
			result += "[color=lightgray]" + texte_a_ecrire[i] + "[/color]"

	text = result
