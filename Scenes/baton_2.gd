extends Sprite2D

@export var audio_player: AudioStreamPlayer
var target_position = Vector2(600,700)
var bpm_zones = [
		{ "start": 5.0, "end": 13.0, "bpm": 114 },
		{ "start": 14.0, "end": 22.0, "bpm": 118 },
		{ "start": 22.0, "end": 30.0, "bpm": 122 },
		{ "start": 30.0, "end": 55.0, "bpm": 119 },
		{ "start": 55.0, "end": 62.0, "bpm": 124 },
		{ "start": 62.0, "end": 69.0, "bpm": 128 },
		{ "start": 69.0, "end": 77.0, "bpm": 132 },
		{ "start": 77.0, "end": 84.0, "bpm": 140 },
		{ "start": 84.0, "end": 90.0, "bpm": 144 },
		{ "start": 90.0, "end": 96.5, "bpm": 148 },
		{ "start": 96.5, "end": 103.5, "bpm": 156 },
		{ "start": 103.5, "end": 109.5, "bpm": 160 },
		{ "start": 109.5, "end": 120.0, "bpm": 164 },
		{ "start": 120.0, "end": 126.0, "bpm": 172 },
		{ "start": 126.0, "end": 131.0, "bpm": 180 },
		{ "start": 131.0, "end": 139.0, "bpm": 188 },
	]
	
func get_speed_from_bpm(time: float) -> float:
	var bpm = 114
	for zone in bpm_zones:
		if time >= zone["start"] and time < zone["end"]:
			bpm = zone["bpm"]
			break
	
	var beat_duration = 60.0 / bpm
	return 300.0 / beat_duration


func _ready():
	position = Vector2(900,700)

func _process(delta):
	if (get_tree().get_root().get_node("bande rythmo/AudioStreamPlayer").get_playback_position()-5.78176879882813)>0:
		position = position.move_toward(target_position, get_speed_from_bpm(get_tree().get_root().get_node("bande rythmo/AudioStreamPlayer").get_playback_position()) * delta)
		if position.distance_to(target_position) < 5.0:
			position = Vector2(900,700)
	
