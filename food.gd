extends Area2D

export (int) var hp_restore

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.hp += hp_restore
		queue_free()
