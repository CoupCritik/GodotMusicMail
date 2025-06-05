extends Node2D

var bpm =114
var beat = 0
var topchrono = 5.78176879882813
var tempbeat = 0
signal OnBeat(numbeat:int)
var dico = {
	0:114,
	16:118,
	32:122,
	48:119,
	96:124,
	112:128,
	128:132,
	144:139,
	160:144,
	176:148,
	192:156,
	208:160,
	224:164,
	256:172,
	272:180,
	288:188
}
func _ready() -> void:
	$AudioStreamPlayer.play()
	


func _process(delta: float) -> void:
	if (beat < tempbeat + (($AudioStreamPlayer.get_playback_position()-topchrono)/60)*bpm):
		OnBeat.emit(beat)
		print(beat)
		beat +=1
		
		

func _on_on_beat(numbeat: int) -> void:
	if dico.has(numbeat):
		bpm = dico[numbeat]
		tempbeat = beat
		print("Nouveau bpm")
		topchrono = $AudioStreamPlayer.get_playback_position()
