extends Node2D

var normal_scale := Vector2(0.12, 0.12)
var beat_scale := Vector2(0.2, 0.2) # grossissement temporaire
var current_scale := normal_scale
var shrink_speed := 0.6 #vitesse à laquelle on revient à la normale, il faudra qu'on adapte pour que ce soit le plus clean possible.

func _process(delta: float) -> void:
	scale = scale.lerp(normal_scale, delta * shrink_speed) #on revient à la taille normale

func on_beat_triggered(numbeat: int) -> void:
	scale = beat_scale #on rescale au moment du signal du beat (un retard possible ?)
	#peut-être là où ça marche pas...
