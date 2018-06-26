extends Area2D

export (int) var SPEED
var move_vector
var detect_pos
var player

# figure out who the parent is for movement
func _ready():
	detect_pos = true
	player = get_parent()

func _process(delta):
	# figure out how I should move
	if detect_pos:
		move_vector = get_local_mouse_position() - position
		move_vector = move_vector.normalized()
	# move
	position += move_vector * delta * SPEED
	position -= player.velocity * delta
	
	detect_pos = false

# destroy the projectile if relevant
func _on_Visibility_screen_exited():
	queue_free()

func _on_projectile_body_entered(body):
	if (body.is_in_group("kill_proj")):
		queue_free()
