extends Node

signal reset_highscore
signal disable_jumpscare
signal enable_jumpscare
signal jumpscare
signal jumpscare_next_score

func _input(event):
	print(event)
	if event.is_action_pressed("reset_highscore"):
		HighScore.high_score = 0
		HighScore.save_score()
		reset_highscore.emit()
	# Disable jumpscare
	elif event.is_action_pressed("disable_jumpscare"):
		JumpscareManager.disable_jumpscares()
		disable_jumpscare.emit()
	# Enables jumpscare only if disabled
	elif event.is_action_pressed("enable_jumpscare"):
		JumpscareManager.enable_jumpscares()
		enable_jumpscare.emit()
	# Jumpscare immediately
	elif event.is_action_pressed("jumpscare"):
		jumpscare.emit()
	# Set jumpscare to next score
	elif event.is_action_pressed("jumpscare_next_score"):
		jumpscare_next_score.emit()
