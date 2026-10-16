extends Line2D



@onready var bird = $"../.."

@export var scroll_speed : int = 300
@export var max_points : int = 30
@export var trail_offset: Vector2 = Vector2(-19, 0)

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	for i in range(points.size()):
		var pt = points[i]
		pt.x -= scroll_speed * delta
		set_point_position(i, pt)
		
		
		
	var spawn_pos = get_parent().global_position + trail_offset.rotated(bird.rotation)
	
	add_point(spawn_pos)
	
	
	if points.size() > max_points:
		remove_point(0)
		
