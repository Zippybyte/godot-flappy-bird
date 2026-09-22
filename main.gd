extends Node

@export var pipe_scene: PackedScene
var pipe_padding: int = 100

var score : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true

func start_game():
	get_tree().paused = false # Unpause the game
	generate_pipe()
	$PipeTimer.start() # Start making pipes
	$ScoreLabel.text = "SCORE: " + str(score)
	$StartGame.hide() # Hide the start game text

func generate_pipe():
	var pipe = pipe_scene.instantiate()
	
	# Set location of the pipe
	pipe.position.x = get_window().size.x + 100
	pipe.position.y = randi_range(100, 600)
	
	# Attach signal to increase score when bird goes between a pipe
	pipe.scored.connect(scored)
	
	# Put the Node into the scene tree
	add_child(pipe)

# Increase score whenever the bird passes through a pipe.
func scored():
	score += 1
	$ScoreLabel.text = "SCORE: " + str(score)

# Spawn pipes when the timer runs out
func _on_pipe_timer_timeout() -> void:
	generate_pipe()

# Handle game over functionality
func _on_bird_game_over() -> void:
	$GameOver.show()
	$PipeTimer.stop()
	# Stop pipes and ground from moving
	get_tree().set_group("moving_objects", "process_mode", Node.PROCESS_MODE_DISABLED)


func _on_start_game_start_game() -> void:
	start_game()
