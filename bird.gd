extends CharacterBody2D

signal failed

@export var gravity : int = 500
@export var flap_strength : int = -400
@export var max_vel : int = 600

var alive : bool = true

func _ready():
	$AnimatedSprite2D.play() # Start Animation
	velocity.y = flap_strength # Flap when player starts

func _physics_process(delta: float) -> void:

	# Gravity
	velocity.y += gravity * delta
	
	# Only fly when player presses flap and alive
	if Input.is_action_pressed("flap") and alive:
		velocity.y = flap_strength
	
	# Cap max velocity
	if velocity.y > max_vel:
		velocity.y = max_vel
	
	# Rotate to face the direction the bird is moving up or down
	if alive:
		set_rotation(deg_to_rad(velocity.y * 0.05))
	
	# Move and collide
	var collision = move_and_collide(velocity * delta)
	
	# If they collide with anything, game over
	if collision:
		game_over()

func game_over():
	alive = false
	$CollisionShape2D.disabled = true # Disable collision
	$AnimatedSprite2D.stop() # Stop animation
	set_rotation(PI/2) # Rotate bird to face straight down
	failed.emit() # Emit signal
