extends Node2D

var beat = 0


signal OnBeat(numbeat:int) #Signal qui sera envoyé à chaque beat
signal sendBeat(numbeat:int) #Signal qui sera envoyé quand un beat doit être instancié

#Scènes à instancier

var texte = preload("res://Scenes/texte.tscn")
var barres = preload("res://Scenes/barres.tscn")
var hitlist = [] #Liste de si on doit appuyer à ce beat où non

var bpmlist = [] #Liste du bpm associé à chaque beat

var topsbeats = [] #Timing de CHAQUE BEAT

var sendlist = [] #Les topschronos de chacun des beats

var sendindex = 0 #Prochain beat à envoyer
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
	336:149.8346
}


func _ready() -> void:
	
	#Lancer la musique
	$AudioStreamPlayer.play()
	
	#initialisation du texte
	var text = texte.instantiate()
	add_child(text)
	move_child(text, 0)
	
	#Initialisation de hitlist
	for i in range (288):
		if ((i+1)%16==0):
			hitlist.append(false)
		else:
			hitlist.append(true)
			
	for i in range (48):
		if (i%16==2) or (i%16==3) or (i%16==6) or (i%16==7):
			hitlist.append(false)
		else:
			hitlist.append(true)
	
	hitlist.append(true)
	
		
	
	#Initialisation de bpmlist
	for i in range(len(dico.keys())-1):
		for j in range(dico.keys()[i+1]-dico.keys()[i]):
			bpmlist.append(dico[dico.keys()[i]])
	bpmlist.append(110.0)
	#Initialisation de topsbeats
	for i in range(337):
		topsbeats.append(chronoschangements[(i/16)*16]+(i%16)*60.0/dico[i/16*16])
	
	
	for i in range(337):
		sendlist.append(topsbeats[i]-4*60.0/dico[i/16*16])




func _process(delta: float) -> void:

	#Détecte s'il faut frapper un beat à cet instant précis
	if beat<337 and $AudioStreamPlayer.get_playback_position()>topsbeats[beat]:
		OnBeat.emit(beat)
		print(beat)
		beat +=1
	
	#Détecte s'il faut envoyer un beat à cet instant précis
	if sendindex<337 and $AudioStreamPlayer.get_playback_position()>sendlist[sendindex]:
		sendBeat.emit(sendindex)
		sendindex+=1
	


func _on_on_beat(numbeat: int) -> void:
	
	#Si c'est un beat à frapper, je fais grossir la touche
	if hitlist[numbeat]:
		$Touche._on_beat_triggered()

func _on_send_beat(numbeat: int) -> void:
	
	if hitlist[numbeat]:
		var b = barres.instantiate()
		
		b.speedscale = bpmlist[numbeat]/(60*4.0)
		add_child(b)
