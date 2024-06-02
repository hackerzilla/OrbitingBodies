extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
	# Quit the game
	# Notify all nodes that the application is closing
		get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	# Close the application
		get_tree().quit()
	if Input.is_action_just_pressed("ui_select"):
		get_tree().paused = not get_tree().paused
