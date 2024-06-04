extends RigidBody2D
class_name Body

@onready var collider: CollisionShape2D
var _material

func _ready():
	_material = get_node("Sprite2D").material

func _process(delta):
	var speed = linear_velocity.length()
	_material.set_shader_parameter("velocity", linear_velocity)
	_material.set_shader_parameter("speed", speed)
