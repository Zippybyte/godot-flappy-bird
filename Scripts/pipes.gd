extends Node2D

signal scored

@onready var scroll_speed : float = GameSettings.scroll_speed
@export var dead_zone : int = -50

func _physics_process(delta: float) -> void:
	# Move the pipe to the left by scroll_speed every second
	position.x -= scroll_speed * delta
	# Delete the pipe if it goes past the dead_zone
	if position.x < dead_zone:
		queue_free()

func _on_score_area_body_entered(body: Node2D) -> void:
	$ScoreSound.play()
	scored.emit()
