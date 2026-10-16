extends CanvasLayer

signal start_game

# This is connected to main.gd
func _on_button_pressed() -> void:
	start_game.emit()
