extends CanvasLayer

var allow_input: bool = false

func _on_button_pressed() -> void:
	reset_game()

func game_over() -> void:
	$LockOutTimer.start()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("flap") and allow_input:
		reset_game()

func reset_game() -> void:
	get_tree().reload_current_scene() # Reload the whole scene

func _on_lock_out_timer_timeout() -> void:
	allow_input = true
	$PressAnyButton.visible = true
