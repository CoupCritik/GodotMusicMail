extends Sprite2D
var speedscale
func _ready():
	$AnimationPlayer.speed_scale = speedscale
	$AnimationPlayer.play("slide")
	await $AnimationPlayer.animation_finished
	queue_free()
