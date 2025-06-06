extends Node2D

var speedscale
func _ready():
	$AnimationPlayer.speed_scale = speedscale
	$AnimationPlayer.play("Slide")
	await $AnimationPlayer.animation_finished
	queue_free()
