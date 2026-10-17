extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play()


func _on_jumpscare_sound_finished() -> void:
	queue_free()
