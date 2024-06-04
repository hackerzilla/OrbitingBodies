extends Node2D
class_name Simulation

@export var num_bodies: int = 3
@export var collisions_enabled: bool = false
@export var explosions_enabled: bool = false
@export var body_scene: PackedScene


# Idea: have explosions at random locations every 5 seconds  or so
# explosion can be coded as a force divided by the distance squared to the center
var explosion_force = 300880
var explosion_frequency = 10.0
var bodies
var G_const = 1000
var max_dist: float

@onready var camera = get_node("Camera2D")

func _ready():
	# Spawn the bodies at random locations
	var rng = RandomNumberGenerator.new()
	bodies = get_node("Bodies")
	for i in range(num_bodies):
		var body = body_scene.instantiate()
		var random_location = Vector2(rng.randfn(0, 1000), rng.randfn(0, 1000))
		bodies.add_child(body)
		body.global_position = random_location
		
	bodies = bodies.get_children()
	var timer = get_node("Timer") as Timer
	timer.wait_time = explosion_frequency
	if collisions_enabled:
		for body in bodies:
			body.get_node("CollisionShape2D").disabled = false
	else:
		for body in bodies:
			body.get_node("CollisionShape2D").disabled = true
	if explosions_enabled:
		timer.timeout.connect(explosion)
	var camera = get_node("Camera")
	camera._on_ready()
	get_tree().paused = true

func explosion():
	for body in bodies:
		var direction = camera.global_position.direction_to(body.global_position)
		body.apply_central_impulse(direction * explosion_force)

func _physics_process(delta):
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
	
	for body_a in bodies:
		for body_b in bodies:
			if body_a != body_b:
				var distance_squared = body_a.global_position.distance_to(body_b.global_position)
				var g_force = body_a.mass * body_b.mass / distance_squared
				var force_vector = G_const * g_force * body_a.global_position.direction_to(body_b.global_position) 
				body_a.apply_central_force(force_vector)
