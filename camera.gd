extends Camera2D

# Array of objects to keep in view
var bodies = []

# Set the margin to provide some space around the objects
var margin = 100.0
var zoom_text
var scaler = 0.3

func _ready():
	make_current()
	bodies = get_parent().get_node("Bodies").get_children()
	zoom_text = get_node("Zoom")

func _process(delta):
	var min_x = INF
	var max_x = -INF
	var min_y = INF
	var max_y = -INF

	# Find the bounding box of all tracked objects
	for body in bodies:
		var pos = body.global_position
		if pos.x < min_x:
			min_x = pos.x
		if pos.x > max_x:
			max_x = pos.x
		if pos.y < min_y:
			min_y = pos.y
		if pos.y > max_y:
			max_y = pos.y

	# Calculate the center of the bounding box
	#var center = Vector2((min_x + max_x) / 2, (min_y + max_y) / 2)
	var center = Vector2.ZERO
	global_position = center

	# Calculate the size of the bounding box
	#var width = max_x - min_x
	#var height = max_y - min_y
	var width = 2 * max(max_x, abs(min_x))
	var height = 2 * max(max_y, abs(min_y))
	
	# Set the zoom based on the size of the bounding box
	# Adjusting the camera zoom to keep all objects in view
	var screen_size = get_viewport_rect().size
	var zoom_x = (width + margin) / screen_size.x
	var zoom_y = (height + margin) / screen_size.y
	var zoom_max = max(zoom_x, zoom_y)
	var zoom_max_inv = 1 / zoom_max
	zoom = Vector2(zoom_max_inv, zoom_max_inv)  # Ensure zoom is not less than 1 (original size)
	
	#for body in bodies:
		#var sprite = body.get_node("Sprite2D")
		#sprite.scale = Vector2(zoom_max, zoom_max) * scaler
	
	#zoom_text.text = "Zoom: " + String.num(zoom_max)
