extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	$JumpscareSound.pitch_scale -= randf_range(0, 0.7)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_jumpscare_sound_finished() -> void:
	queue_free()
