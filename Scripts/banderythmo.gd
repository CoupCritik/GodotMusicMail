extends Node2D

var bpm =119
var beat = 0

func _ready() -> void:
	$AudioStreamPlayer.play()
	
	
func _process(_delta: float) -> void:
	if (beat < (($AudioStreamPlayer.get_playback_position()-5.78176879882813)/60)*bpm):
		beat+=1
		print(beat)
		print($AudioStreamPlayer.get_playback_position())
