extends Area2D

export (int) var SPEED
var move_vector
var detect_pos
var player

func _ready():
	detect_pos = true
	player = get_parent()

func _process(delta):
	if detect_pos:
		move_vector = get_local_mouse_position() - position
		move_vector = move_vector.normalized()
	position += move_vector * delta * SPEED
	position -= player.velocity * delta
	
	detect_pos = false

func _on_Visibility_screen_exited():
	queue_free()

func _on_projectile_body_entered(body):
	if (body.is_in_group("wall")):
		queue_free()
	if body.is_in_group("enemy"):
		queue_free()
