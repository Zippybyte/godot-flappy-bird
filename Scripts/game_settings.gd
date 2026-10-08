extends Node

@export var scroll_speed: float = 300
@export var time_between_pipes: float = 1.5
@onready var units_between_pipes: float = scroll_speed * time_between_pipes
