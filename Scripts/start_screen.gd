extends CanvasLayer



signal start_game

var playing : bool = false

func _input(event):
	if playing == false and event.is_action_pressed("flap"):
		start_game.emit()
		playing = true
