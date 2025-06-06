extends Node2D

var bpm = 110.43
var beat = 0

var topchrono = 5.4569 #Début de chaque changement de bpm
var tempbeat = 0 #Numéro du beat de début de changement de phrase

signal OnBeat(numbeat:int) #Signal qui sera envoyé à chaque beat
signal sendBeat() #Signal qui sera envoyé quand un beat doit être instancié

var tempnum = 4
var baton = preload("res://Scenes/baton.tscn")
var texte = preload("res://Scenes/texte.tscn")

#Tous les beats auquel il faut changer le bpm
var dico = {
	0:110.43,
	16: 116.829,
	32:120.45,
	48:118.95,
	64:118.8089,
	80:119.31,
	96:123.49,
	112:126.7,
	128:132.5,
	144:137.8,
	160:143.21,
	176:150.011,
	192:159.95,
	208:160.46,
	224:163.259,
	240:163.69,
	256:171.505,
	272:175.56,
	288:192.415,
	304:192.6125,
	320:185.5, #Ou 192 selon expérience
	336:110.0
}
var chronoschangements = {
	0:5.4569,
	16: 14.1441,
	32:22.3398,
	48:30.3447,
	64:38.4062,
	80:46.5496,
	96:54.5894,
	112:62.3462,
	128:69.9230,
	144:77.1622,
	160:84.1470,
	176:90.8563,
	192:97.2435,
	208:103.2383,
	224:109.2203,
	240:115.1071,
	256:120.9452,
	272:126.5591,
	288:132.0463,
	304:137.0349,
	320:142.0246,
	336:148.0
}
var hitlist = [] #Liste de si on doit appuyer à ce beat où non

var bpmlist = [] #Liste du bpm associé à chaque beat

var topslist = []


func _ready() -> void:
	
	$AudioStreamPlayer.play()
	
	#initialisation du texte
	var text = texte.instantiate()
	add_child(text)
	move_child(text, 0)
	
	#Initialisation de hitlist
	for i in range (400):
		if ((i+1)%16==0):
			hitlist.append(false)
		else:
			hitlist.append(true)
		
	#Initialisation de bpmlist
	for i in range(len(dico.keys())-1):
		for j in range(dico.keys()[i+1]-dico.keys()[i]):
			bpmlist.append(dico[dico.keys()[i]])
	
	#Initialisation de topslits
	for i in range(400):
		top
	


func _process(delta: float) -> void:
	if (beat < tempbeat + (($AudioStreamPlayer.get_playback_position()-topchrono)/60)*bpm):
		OnBeat.emit(beat)
		
		print(str(beat) + " " + str(hitlist[beat]))
		
		beat +=1
		
	
	if ($AudioStreamPlayer.get_playback_position()<5.78176879882813):
		if ($AudioStreamPlayer.get_playback_position()>5.78176879882813-tempbeat*60.0/114):
			pass
	


func _on_on_beat(numbeat: int) -> void:
	if hitlist[numbeat+4]:
		var b = baton.instantiate()
		print(b)
		b.speedscale = bpmlist[beat+4]/(60*4.0)
		add_child(b)
	
	if dico.has(numbeat):
		bpm = dico[numbeat]
		tempbeat = beat
		print("Nouveau bpm")
		topchrono = $AudioStreamPlayer.get_playback_position()
		
	
