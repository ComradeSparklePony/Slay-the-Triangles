extends Area2D

export (int) var ROT_SPEED

func _process(delta):
	rotate(0.01 * ROT_SPEED)
