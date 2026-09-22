extends StaticBody2D

@export var scroll_speed : int = 100
var scroll : int = 0
var sprite_width : int

func _ready():
	sprite_width = $Sprite2D.texture.get_width()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Scroll increases until it reaches half the sprite width
	# then resets to 0. Illusion of constantly moving ground.
	scroll += scroll_speed * delta
	if scroll >= sprite_width / 2:
		scroll = 0
	# Move the ground left as the scroll increases
	position.x = -scroll
