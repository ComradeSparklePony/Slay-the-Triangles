extends KinematicBody2D

export (int) var SPEED

var player
var velocity

func _ready():
	player = get_parent().get_node("player")

func _process(delta):
	velocity = player.position - position
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
	
	move_and_collide(Vector2(velocity.x, 0) * delta)
	move_and_collide(Vector2(0, velocity.y) * delta)