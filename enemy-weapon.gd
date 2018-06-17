extends Area2D

export (int) var ROT_SPEED

func _process(delta):
	rotate(0.01 * ROT_SPEED)
	





func _on_enemyweapon_area_entered(area):
	if area.is_in_group("projectile"):
		queue_free()
