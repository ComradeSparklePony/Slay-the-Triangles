extends Area2D

export (int) var SPEED
var move_vector
var detect_pos

func _ready():
	detect_pos = true

func _process(delta):
	if detect_pos:
		move_vector = get_global_mouse_position() - position
		move_vector = move_vector.normalized()
	position += move_vector * delta * SPEED
	detect_pos = false
