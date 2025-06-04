extends Node2D

var bpm =119
var beat = 0

func _ready() -> void:
	get_tree().get_root().get_node("bande rythmo/AudioStreamPlayer").play()
	
	
func _process(_delta: float) -> void:
	if (beat < ((get_tree().get_root().get_node("bande rythmo/AudioStreamPlayer").get_playback_position()-5.78176879882813)/60)*bpm):
		beat+=1
		print(beat)
		print(get_tree().get_root().get_node("bande rythmo/AudioStreamPlayer").get_playback_position())
