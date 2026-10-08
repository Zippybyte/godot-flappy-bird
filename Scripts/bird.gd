extends CharacterBody2D

signal game_ended

@export var gravity : int = 500
@export var flap_strength : int = -400
@export var max_vel : int = 600

var alive : bool = true

func setup():
	$AnimatedSprite2D.play() # Start Animation
	flap() # Flap when player starts

func _input(event):
	if event.is_action_pressed("flap") and alive:
		flap()

func flap():
	velocity.y = flap_strength
	$FlapSound.play()

func _physics_process(delta):
	velocity.y += gravity * delta
	
	if velocity.y > max_vel:
		velocity.y = max_vel
	
	if alive:
		set_rotation(deg_to_rad(velocity.y * 0.05))
	
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		game_over()

func game_over():
	alive = false
	$CollisionShape2D.disabled = true # Disable collision
	$AnimatedSprite2D.stop() # Stop animation
	set_rotation(PI/2) # Rotate bird to face straight down
	game_ended.emit()


func _on_main_game_started() -> void:
	setup()
