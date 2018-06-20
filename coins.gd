extends RigidBody2D

#randomize velocity and timer
func _ready():
	randomize()
	linear_velocity = Vector2(rand_range(5, 25), rand_range(5, 25))
	$Timer.wait_time = rand_range(3, 10)
	$Timer.start()

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		queue_free()

func _on_Timer_timeout():
	queue_free()
