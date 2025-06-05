extends Node2D

var bpm =114.0
var beat = 0

var topchrono = 5.7413 #Début de chaque changement de bpm
var tempbeat = 0 #Numéro du beat de début de changement de phrase

signal OnBeat(numbeat:int) #Signal qui sera envoyé à chaque beat
signal sendBeat() #Signal qui sera envoyé quand un beat doit être instancié

var tempnum = 4
var baton = preload("res://Scenes/baton.tscn")

#Tous les beats auquel il faut changer le bpm
var dico = {
	0:114.0,
	16:118.0,
	32:122.0,
	48:119.0,
	96:124.0,
	112:128.0,
	128:132.0,
	144:139.0,
	160:144.0,
	176:148.0,
	192:156.0,
	208:160.0,
	224:164.0,
	256:172.0,
	272:180.0,
	288:188.0
}

var hitlist = [] #Liste de si on doit appuyer à ce beat où non

var bpmlist = [] #Liste du bpm associé à chaque beat

var topslist = []


func _ready() -> void:
	
	$AudioStreamPlayer.play()
	
	#Initialisation de hitlist
	for i in range (300):
		if ((i+1)%16==0):
			hitlist.append(false)
		else:
			hitlist.append(true)
		
	#Initialisation de bpmlist
	for i in range(len(dico.keys())-1):
		for j in range(dico.keys()[i+1]-dico.keys()[i]):
			bpmlist.append(dico[dico.keys()[i]])
	
		
	


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
		b.speedscale = bpmlist[beat+4]/(60*4.0)
		add_child(b)
	
	if dico.has(numbeat):
		bpm = dico[numbeat]
		tempbeat = beat
		print("Nouveau bpm")
		topchrono = $AudioStreamPlayer.get_playback_position()
		
	
