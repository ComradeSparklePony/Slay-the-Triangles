extends KinematicBody2D

export (int) var ROT_SPEED
var velocity

func _ready():
	$tri2.rotate(2*3.1415926535)
	velocity = Vector2(0,0)

func _process(delta):
	$tri1.rotate(ROT_SPEED * delta)
	$tri2.rotate(ROT_SPEED * delta * -1)
	velocity += Vector2(rand_range(-5,5),rand_range(-5,5))
