extends Node2D
class_name Simulation

var bodies
var G_const = 1000
var max_dist: float

func _ready():
	bodies = get_node("Bodies")
	bodies = bodies.get_children()

func _process(delta):
	# Find the max distance to rescale the viewport acordingly.
	max_dist = 0.0
	for body in bodies:
		var dist = body.global_position.distance_to(Vector2.ZERO)
		if dist > max_dist:
			max_dist = dist
	# calculate how much we need to rescale the viewport
	# 1920x1080
	var horiz = max_dist / 1920
	var vert = max_dist / 1080
	# idk?!
	horiz = 1 / horiz
	vert = 1 / vert
	var scale = max(horiz, vert)
	#get_tree().get_root().content_scale_size 

func _physics_process(delta):
	for body_a in bodies:
		for body_b in bodies:
			if body_a != body_b:
				var distance_squared = body_a.global_position.distance_to(body_b.global_position)
				var g_force = body_a.mass * body_b.mass / distance_squared
				var force_vector = G_const * g_force * body_a.global_position.direction_to(body_b.global_position) 
				print(force_vector)
				body_a.apply_central_force(force_vector)
