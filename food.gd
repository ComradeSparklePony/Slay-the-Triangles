extends Area2D

export (int) var hp_restore

var direction = 1

func _on_food_body_entered(body):
	if body.is_in_group("player"):
		body.hp += hp_restore
		body.hp = min(body.max_hp, body.hp)
		queue_free()
