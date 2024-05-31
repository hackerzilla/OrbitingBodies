extends Camera2D

# Array of objects to keep in view
var objects_to_track = []

# Set the margin to provide some space around the objects
var margin = 50.0

func _ready():
	make_current()
	objects_to_track = get_parent().get_node("Bodies").get_children()

# Add objects to track
func add_object_to_track(object):
	objects_to_track.append(object)

# Remove objects from tracking
func remove_object_to_track(object):
	objects_to_track.erase(object)

func _process(delta):
	var min_x = INF
	var max_x = -INF
	var min_y = INF
	var max_y = -INF

	# Find the bounding box of all tracked objects
	for object in objects_to_track:
		var pos = object.global_position
		if pos.x < min_x:
			min_x = pos.x
		if pos.x > max_x:
			max_x = pos.x
		if pos.y < min_y:
			min_y = pos.y
		if pos.y > max_y:
			max_y = pos.y

	# Calculate the center of the bounding box
	var center = Vector2((min_x + max_x) / 2, (min_y + max_y) / 2)
	global_position = center

	# Calculate the size of the bounding box
	var width = max_x - min_x
	var height = max_y - min_y

	# Set the zoom based on the size of the bounding box
	# Adjusting the camera zoom to keep all objects in view
	var screen_size = get_viewport_rect().size
	var zoom_x = (width + margin) / screen_size.x
	var zoom_y = (height + margin) / screen_size.y
	var zoom = max(zoom_x, zoom_y)
	zoom = Vector2(zoom, zoom)  # Ensure zoom is not less than 1 (original size)
