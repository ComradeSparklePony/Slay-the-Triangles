extends Area2D

export (int) var SPEED
var direction

func _ready():
	direction = get_angle_to(get_global_mouse_position())

func _process(delta):
	position += Vector2(SPEED, 0)+direction * delta
