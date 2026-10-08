extends StaticBody2D

@onready var scroll_speed : float = GameSettings.scroll_speed
var scroll : float = 0
var sprite_width : float

func _ready():
	sprite_width = $Sprite2D.texture.get_width()

func _process(delta: float) -> void:
	# Scroll increases until it reaches half the sprite width
	# then resets to 0. Illusion of constantly moving ground.
	scroll += scroll_speed * delta
	if scroll >= sprite_width / 2:
		scroll = 0
	# Move the ground left as the scroll increases
	position.x = -scroll
