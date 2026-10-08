extends Line2D

@onready var bird = $"../.."

@onready var scroll_speed : float = GameSettings.scroll_speed
@export var max_points: int = 30 # Determines how long the trail is
@export var trail_offset: Vector2 = Vector2(-19, 0)

func _process(delta):
	# Move all of the points to the left
	if bird.alive:
		for i in range(points.size()):
			var pt: Vector2 = points[i]
			pt.x -= scroll_speed * delta
			set_point_position(i, pt)
	
	var spawn_pos = get_parent().global_position + trail_offset.rotated(bird.rotation)
	
	# Add the point
	add_point(spawn_pos)
	
	# Remove the oldest point if we go over
	if points.size() > max_points:
		remove_point(0)
