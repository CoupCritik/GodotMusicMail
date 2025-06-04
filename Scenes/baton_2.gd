extends Sprite2D

var target_position = Vector2(600,700)
var speed = 2560

func _read():
	position = Vector2(1200,700)

func _process(delta):
	position = position.move_toward(target_position, speed * delta)
	if position.distance_to(target_position) < 5.0:
		position = Vector2(1200,700)
	
