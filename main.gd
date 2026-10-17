extends Node

@export var pipe_scene: PackedScene
@export var pipe_range: int = 200

# Jumpscare min 
@export var jumpscare_min: int = 10
@export var jumpscare_max: int = 18
@export var jumpscare_enabled: bool = false 

@export var jumpscare_scenes: Array[PackedScene]

var score : int = 0

const PIPE_PADDING: int = 100 # Sets how far the pipe spawns off screen
var pipe_spawn_location : Vector2

var is_day : bool = true
var randomJumpscare: int = -1

func _ready() -> void:
	# Pipe spawns off screen with PIPE_PADDING distance from right edge of screen.
	# Pipe y value is set to the middle point of the background.
	pipe_spawn_location.x = $Background.texture.get_width() + PIPE_PADDING
	pipe_spawn_location.y = $Background.texture.get_height() / 2
	get_tree().paused = true
	
	HighScore.load_score()
	$HighScoreLabel.text = "HIGH SCORE: " + str(HighScore.high_score)
	
	if (jumpscare_enabled):
		randomize_jumpscare_score()

func start_game():
	get_tree().paused = false # Unpause the game
	$StartScreen.hide()
	generate_pipe()
	$PipeTimer.start()

func _on_start_screen_start_game() -> void:
	start_game()

func generate_pipe():
	var pipe = pipe_scene.instantiate()
	
	# Set location of the pipe
	pipe.position = pipe_spawn_location
	
	# Add an offset from the center of the background
	pipe.position.y += randi_range(-pipe_range, pipe_range)
	
	pipe.scored.connect(increment_score)
	
	# Put the Node into the scene tree
	add_child(pipe)

func increment_score():
	score += 1
	$ScoreLabel.text = "SCORE: " + str(score)
	if score > HighScore.high_score:
		HighScore.high_score = score
		$HighScoreLabel.text = "HIGH SCORE: " + str(HighScore.high_score)
		
	if score % 10 == 0:
		if is_day:
			%AnimationPlayer.play("day_night")
			is_day = false
		else:
			%AnimationPlayer.play_backwards("day_night")
			is_day = true

	if randomJumpscare == score:
		trigger_jumpscare()
		randomize_jumpscare_score()

func trigger_jumpscare():
	var jumpscare_scene: PackedScene = jumpscare_scenes.pick_random()
	var jumpscare = jumpscare_scene.instantiate()
	add_child(jumpscare)
	
func randomize_jumpscare_score():
	randomJumpscare = randi_range(jumpscare_min, jumpscare_max) + score

func _input(event):
	if event.is_action_pressed("reset_highscore"):
		HighScore.high_score = 0
		HighScore.save_score()
	# Disable jumpscare
	elif event.is_action_pressed("disable_jumpscare"):
		randomJumpscare = -1
	# Enables jumpscare only if disabled
	elif event.is_action_pressed("enable_jumpscare"):
		if (randomJumpscare == -1):
			randomize_jumpscare_score()
	# Jumpscare immediately
	elif event.is_action_pressed("jumpscare"):
		trigger_jumpscare()
	# Set jumpscare to next score
	elif event.is_action_pressed("jumpscare_next_score"):
		randomJumpscare = score + 1


func _on_pipe_timer_timeout() -> void:
	generate_pipe()

func _on_bird_game_ended() -> void:
	
	HighScore.save_score()
	if score > HighScore.high_score:
		HighScore.high_score = score
	
	$GameOver.show()
	$GameOver.game_over() 
	$PipeTimer.stop()
	# Stop pipes and ground from moving
	get_tree().set_group("moving_objects", "process_mode", Node.PROCESS_MODE_DISABLED)
