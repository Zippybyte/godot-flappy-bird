extends CanvasLayer

func _on_button_pressed() -> void:
	reset_game()

func reset_game():
	get_tree().reload_current_scene() # Reload the whole scene
