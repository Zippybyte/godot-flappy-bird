extends Node

@export var pipe_scene: PackedScene
@export var pipe_range: int = 200

const PIPE_PADDING: int = 100 # Sets how far the pipe spawns off screen

var pipe_spawn_location : Vector2

var score : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Pipe spawns off screen to the right with PIPE_PADDING distance from right edge of screen.
	# Pipe y value is set to the middle point of the background.
	pipe_spawn_location = Vector2(get_window().size.x + PIPE_PADDING, $Background.texture.get_height() / 2)
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
	pipe.position = pipe_spawn_location
	
	# Add an offset from the center of the background
	pipe.position.y += randi_range(-pipe_range, pipe_range)
	
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
