extends Sprite2D

@export var audio_player: AudioStreamPlayer
var target_position = Vector2(600,700)
var speed = 1216.7

func _read():
	position = Vector2(1200,700)

func _process(delta):
	if (get_tree().get_root().get_node("bande rythmo/AudioStreamPlayer").get_playback_position()-5.78176879882813)>0:
		position = position.move_toward(target_position, speed * delta)
		if position.distance_to(target_position) < 5.0:
			position = Vector2(1200,700)
	
