extends Node2D

signal scored

@export var scroll_speed : int = 100
@export var dead_zone : int = -50

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Move the pipe to the left by scroll_speed every second
	position.x -= scroll_speed * delta
	# Delete the pipe if it goes past the dead_zone
	if position.x < dead_zone:
		queue_free()

func _on_score_area_body_entered(body: Node2D) -> void:
	scored.emit()
